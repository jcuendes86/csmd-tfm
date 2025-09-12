# Pipeline de ETL con Dataflow

Este directorio contiene los componentes para un pipeline de ETL (Extracción, Transformación y Carga) implementado con Apache Beam y ejecutado en Google Cloud Dataflow. El pipeline está diseñado para procesar un conjunto de datos de coches de segunda mano, transformarlos y cargarlos en una tabla de BigQuery para su posterior análisis y entrenamiento de modelos de Machine Learning.

## Descripción del Proceso

El pipeline realiza los siguientes pasos:

1.  **Extracción**: Lee los datos desde un archivo CSV almacenado en un bucket de Google Cloud Storage.
2.  **Transformación**:
    *   Limpia y normaliza los datos (ej. elimina valores nulos, convierte tipos de datos).
    *   Realiza ingeniería de características si es necesario para adaptar los datos al modelo de ML.
    *   Valida la estructura y el esquema de los datos.
3.  **Carga**: Inserta los datos procesados en una tabla específica de BigQuery.

## Estructura del Directorio

*   `cars_dataset_pipeline.py`: Contiene el código fuente principal del pipeline de Apache Beam escrito en Python.
*   `requirements.txt`: Enumera las dependencias de Python necesarias para ejecutar el pipeline.
*   `Dockerfile`: Define un contenedor Docker para empaquetar el pipeline y sus dependencias, facilitando su ejecución en entornos aislados.
*   `cloudbuild.yaml`: Archivo de configuración para Google Cloud Build. Automatiza el proceso de construcción del contenedor Docker y su despliegue.
*   `dataflow_job.yaml`: (Opcional) Archivo de configuración que puede contener los parámetros para lanzar un job de Dataflow, como las rutas de entrada/salida y otros ajustes.
*   `README.md`: Este archivo.

