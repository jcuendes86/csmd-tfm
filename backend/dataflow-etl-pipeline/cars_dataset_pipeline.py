"""
Pipeline de Dataflow para procesar el dataset de coches y cargarlo en BigQuery.

Este script define un pipeline de Apache Beam que:
1. Lee un fichero CSV desde Google Cloud Storage.
2. Limpia y transforma los datos.
3. Elimina registros duplicados.
4. Carga los datos limpios en una tabla de BigQuery.
"""

import argparse
import logging
import csv
from io import StringIO
import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions
import unicodedata

# Esquema de la tabla de destino en BigQuery.
TABLE_SCHEMA = {
    'fields': [
        {'name': 'make', 'type': 'STRING', 'mode': 'NULLABLE'},
        {'name': 'model', 'type': 'STRING', 'mode': 'NULLABLE'},
        {'name': 'version', 'type': 'STRING', 'mode': 'NULLABLE'},
        {'name': 'price', 'type': 'FLOAT', 'mode': 'NULLABLE'},
        {'name': 'fuel', 'type': 'STRING', 'mode': 'NULLABLE'},
        {'name': 'year', 'type': 'INTEGER', 'mode': 'NULLABLE'},
        {'name': 'kms', 'type': 'INTEGER', 'mode': 'NULLABLE'},
        {'name': 'power', 'type': 'INTEGER', 'mode': 'NULLABLE'},
        {'name': 'doors', 'type': 'INTEGER', 'mode': 'NULLABLE'},
        {'name': 'shift', 'type': 'STRING', 'mode': 'NULLABLE'},
        {'name': 'color', 'type': 'STRING', 'mode': 'NULLABLE'},
        {'name': 'province', 'type': 'STRING', 'mode': 'NULLABLE'},
        {'name': 'country', 'type': 'STRING', 'mode': 'NULLABLE'},
        {'name': 'publish_date', 'type': 'DATETIME', 'mode': 'NULLABLE'},
    ]
}


# Define las columnas esperadas en el fichero CSV de entrada.
CSV_COLUMNS = [
    'url', 'company', 'make', 'model', 'version', 'price', 'price_financed', 'fuel', 'year', 'kms',
    'power', 'doors', 'shift', 'color', 'photos', 'is_professional',
    'dealer', 'province', 'country', 'publish_date', 'insert_date'
]

def normalize_string(text):
    """
    Normaliza un string: lo convierte a mayúsculas y elimina tildes y caracteres especiales.
    
    Args:
        text (str): El texto a normalizar.
        
    Returns:
        str: El texto normalizado.
    """
    # Normaliza el texto para separar los caracteres base de las tildes (NFD).
    nfkd_form = unicodedata.normalize('NFD', text)
    # Filtra para quedarse solo con los caracteres sin tilde y convierte a mayúsculas.
    return "".join([c for c in nfkd_form if not unicodedata.combining(c)]).upper()

class ParseAndCleanDoFn(beam.DoFn):
    """
    DoFn para parsear, limpiar y transformar cada fila del CSV.
    """
    def process(self, element):
        """
        Procesa una fila del CSV.
        
        Args:
            element (str): Una línea del fichero CSV.
            
        Yields:
            dict: Un diccionario con los datos limpios y transformados, listo para ser insertado en BigQuery.
        """
        # Campos requeridos que no pueden ser nulos para que el registro sea válido.
        REQUIRED_FIELDS = {'make', 'model', 'year', 'kms', 'power', 'fuel', 'shift', 'color', 'province', 'country'}

        try:
            # Usamos csv.reader con StringIO para procesar la línea como si fuera un fichero.
            # El delimitador es ';'.
            reader = csv.reader(StringIO(element), delimiter=';')
            row_values = next(reader)

            # Convierte la lista de valores en un diccionario usando las columnas del CSV.
            row_dict = dict(zip(CSV_COLUMNS, row_values))

            output_dict = {}

            # Itera sobre el esquema de BigQuery para procesar solo las columnas que nos interesan.
            for field in TABLE_SCHEMA['fields']:
                col_name = field['name']
                value = row_dict.get(col_name, '').strip()

                # Si el valor está vacío, se convierte en None (NULL en BigQuery).
                if not value:
                    output_dict[col_name] = None
                    continue

                # Intenta la conversión de tipo según el esquema de BigQuery.
                try:
                    if field['type'] == 'INTEGER':
                        # Se convierte a float primero para manejar casos como "150.0".
                        output_dict[col_name] = int(float(value))
                    elif field['type'] == 'FLOAT':
                        output_dict[col_name] = float(value)
                    elif field['type'] == 'DATETIME':
                        # Transforma el formato de fecha 'DD/MM/YY HH:MM' a 'YYYY-MM-DD HH:MM:SS'.
                        parts = value.split(' ')
                        date_parts = parts[0].split('/')
                        day, month, year = date_parts[0], date_parts[1], "20" + date_parts[2]
                        # Asegura el formato correcto para BigQuery (YYYY-MM-DD HH:MM:SS).
                        formatted_datetime = f"{year}-{month.zfill(2)}-{day.zfill(2)} {parts[1]}:00"
                        output_dict[col_name] = formatted_datetime
                    else: # STRING
                        # Aplica la normalización para mayúsculas y sin tildes.
                        output_dict[col_name] = normalize_string(value)

                except (ValueError, TypeError, IndexError) as e:
                    # Si la conversión falla, se registra un warning y el campo se pone a NULL.
                    logging.warning(f"Error de conversión en columna '{col_name}' con valor '{value}'. Error: {e}. Se insertará como NULL.")
                    output_dict[col_name] = None

            # Validación final: comprueba si algún campo requerido es nulo.
            is_valid = True
            for required_field in REQUIRED_FIELDS:
                if output_dict.get(required_field) is None:
                    logging.warning(f"Descartando fila por valor nulo en campo requerido '{required_field}'. Fila original: {row_dict}")
                    is_valid = False
                    break
            
            # Si la fila es válida, se emite para la siguiente etapa del pipeline.
            if is_valid:
                yield output_dict

        except Exception as e:
            # Captura cualquier otro error inesperado durante el parseo de la fila.
            logging.error(f"No se pudo procesar la fila: '{element}'. Error: {e}")
            # Al no hacer 'yield', la fila se descarta automáticamente.

# Índices de las columnas del CSV que forman la clave de negocio para detectar duplicados.
# Basado en CSV_COLUMNS: make=2, model=3, version=4, price=5, fuel=7, year=8, 
# kms=9, power=10, doors=11, shift=12, color=13, province=17, country=18
KEY_INDICES = [2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 17, 18]

def create_business_key(element):
    """
    Crea una clave de negocio única para cada fila del CSV.
    
    Args:
        element (str): Una línea del fichero CSV.
        
    Returns:
        tupla: Una tupla con la clave de negocio y la línea original (clave, elemento).
    """
    try:
        parts = element.split(';')
        # Crea una tupla con los valores de las columnas que forman la clave.
        key = tuple(parts[i] for i in KEY_INDICES)
        return (key, element) # Devuelve (clave_de_negocio, línea_original)
    except IndexError:
        # Si la línea está mal formada y no tiene todas las columnas, se le asigna una clave nula.
        # Esto permite agruparla y descartarla posteriormente.
        return (None, element)


def run(argv=None):
    """
    Función principal que define y ejecuta el pipeline de Beam.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('--input', dest='input', required=True, help='Ruta del fichero CSV de entrada en GCS')
    parser.add_argument('--output_table', dest='output_table', required=True, help='Tabla de salida en BigQuery.')

    known_args, pipeline_args = parser.parse_known_args(argv)
    pipeline_options = PipelineOptions(pipeline_args)

    with beam.Pipeline(options=pipeline_options) as p:
        (
            p
            # Paso 1: Leer el fichero CSV desde GCS, saltando la cabecera.
            | '1. Leer el fichero CSV' >> beam.io.ReadFromText(known_args.input, skip_header_lines=1)
            # Paso 2: Limpiar espacios en blanco al inicio y final de cada línea.
            | '2. Limpiar Espacios' >> beam.Map(lambda line: line.strip())
            # Paso 3: Crear una clave de negocio para cada fila para identificar duplicados.
            | '3. Crear Clave de Negocio' >> beam.Map(create_business_key)
            # Paso 4: Filtrar las filas que no pudieron generar una clave válida.
            | '4. Filtrar Claves Malas' >> beam.Filter(lambda x: x[0] is not None)
            # Paso 5: Agrupar todas las filas por su clave de negocio.
            | '5. Agrupar por Clave' >> beam.GroupByKey()
            # Paso 6: De cada grupo de duplicados, tomar solo el primer registro.
            | '6. Extraer Registro Único' >> beam.Map(lambda x: x[1][0])
            # Paso 7: Limpiar, transformar y validar cada fila.
            | '7. Limpiar y Transformar Filas' >> beam.ParDo(ParseAndCleanDoFn())
            # Paso 8: Escribir los datos limpios en BigQuery.
            | '8. Escribir en BigQuery' >> beam.io.WriteToBigQuery(
                table=known_args.output_table,
                schema=TABLE_SCHEMA,
                # WRITE_TRUNCATE: borra la tabla antes de escribir los nuevos datos.
                write_disposition=beam.io.BigQueryDisposition.WRITE_TRUNCATE,
                # CREATE_IF_NEEDED: crea la tabla si no existe.
                create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED
            )
        )

if __name__ == '__main__':
    # Configura el logging para mostrar mensajes de nivel INFO y superiores.
    logging.getLogger().setLevel(logging.INFO)
    # Ejecuta el pipeline.
    run()