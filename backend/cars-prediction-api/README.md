# API de Predicción de Precios de Coches

Esta API ha sido diseñada para exponer un modelo de BigQuery ML capaz de predecir el precio de coches de segunda mano basado en sus características.

## Características

- **Predicción de Precios**: Endpoint principal para obtener la estimación del valor de un vehículo.
- **Contenerizada**: Lista para desplegar en cualquier entorno compatible con Docker.
- **Integración con Google Cloud**: Preparada para un despliegue sencillo en Cloud Run y utilizando servicios como BigQuery ML.

##  Prerequisites

- [Node.js](https://nodejs.org/)
- [npm](https://www.npmjs.com/)

## Instalación

1. Clona este repositorio:
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   ```
2. Navega al directorio del proyecto:
   ```bash
   cd cars-prediction-api
   ```
3. Instala las dependencias:
   ```bash
   npm run build
   ```

## Configuración

Para que la aplicación funcione correctamente, es necesario configurar las variables de entorno.

1. Crea un fichero `.env` en la raíz del proyecto.
2. Copia el contenido del fichero `env/.env.schema` y ajústalo según tu configuración local o de producción.

### Variables de Entorno

- `SERVER_HOST`: Host para el servidor (por defecto `localhost`).
- `SERVER_PORT`: Puerto para el servidor (por defecto `8080`).
- `TOKEN_HEADER_XFROM`: Token de seguridad para la cabecera `x-from`.
- `GOOGLE_CLOUD_PROJECT`: ID de tu proyecto en Google Cloud.
- `BQ_DATASET_NAME`: Nombre del dataset de BigQuery donde se encuentra el modelo.
- `BQ_ML_MODEL_NAME`: Nombre del modelo de BigQuery ML que se usará para las predicciones.

## Ejecución

### Entorno de Desarrollo

Para iniciar el servidor en modo de desarrollo con recarga automática:

```bash
npm run start:watch
```

## Endpoints de la API

### `POST /predict`

Realiza una predicción del precio de un coche.

**Request Body:**

El body de la petición debe ser un objeto JSON con las características del vehículo. Ejemplo:

```json
{
    "make": "Toyota",
    "model": "Rav4",
    "fuel": "Híbrido",
    "year": 2020,
    "kms": 40000,
    "power": 140,
    "doors": 5,
    "shift": "Automático",
    "color": "Blanco",
    "province": "Ciudad Real",
    "country": "Spain"
}
```

**Response:**

```json
{
    "status": 200,
    "message": "Predicción realizada con éxito.",
    "prediction": {
        "predicted_log_price": 9.755769729614258,
        "predicted_price": 17253.490151448874
    }
}
```

## Despliegue

El despliegue está automatizado para **Google Cloud Run** mediante **Cloud Build**. Al hacer push a la rama principal, un trigger de Cloud Build se encargará de:

1. Instalar las dependencias necesarias
2. Construir la imagen de Docker
3. Subir la imagen a Google Artifact Registry
4. Desplegar la nueva versión en Cloud Run
5. Migrar el tráfico a la nueva versión desplegada
