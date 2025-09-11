# API de Predicción de Precios de Coches

Esta API ha sido diseñada para exponer un modelo de Machine Learning capaz de predecir el precio de coches de segunda mano basado en sus características.

## Características

- **Predicción de Precios**: Endpoint principal para obtener la estimación del valor de un vehículo.
- **Contenerizada**: Lista para desplegar en cualquier entorno compatible con Docker.
- **Integración con Google Cloud**: Preparada para un despliegue sencillo en Cloud Run y utilizando servicios como BigQuery ML.

##  Prerequisites

- [Node.js](https://nodejs.org/) (versión 18 o superior)
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
   npm install
   ```

## Configuración

Para que la aplicación funcione correctamente, es necesario configurar las variables de entorno.

1. Crea un fichero `.env` en la raíz del proyecto.
2. Copia el contenido del fichero `env/.env.schema` y ajústalo según tu configuración local o de producción.

### Variables de Entorno

- `SECRET_ENV_FILE`: Ruta al secret en Google Secret Manager (ej: `projects/PROJECT_ID/secrets/SECRET_NAME/versions/LATEST`).
- `SERVER_LOCAL_ENV`: `true` si se ejecuta en local, `false` en producción.
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
npm run dev
```

### Entorno de Producción

La aplicación está diseñada para ser ejecutada en un contenedor de Docker.

1. **Construir la imagen de Docker:**
   ```bash
   docker build -t cars-prediction-api .
   ```

2. **Ejecutar el contenedor:**
   ```bash
   docker run -p 8080:8080 -e VAR_1=VALOR_1 -e VAR_2=VALOR_2 cars-prediction-api
   ```
   *Nota: Asegúrate de pasar las variables de entorno necesarias utilizando el flag `-e`.*

## Endpoints de la API

### `POST /predict`

Realiza una predicción del precio de un coche.

**Request Body:**

El body de la petición debe ser un objeto JSON con las características del vehículo. Ejemplo:

```json
{
  "brand": "BMW",
  "model": "Serie 3",
  "year": 2018,
  "km": 50000,
  "power": 190,
  "fuel_type": "Diésel"
}
```

**Response:**

```json
{
  "predicted_price": 25000
}
```

## Despliegue

El despliegue está automatizado para **Google Cloud Run** mediante **Cloud Build**. Al hacer push a la rama principal, un trigger de Cloud Build se encargará de:

1. Construir la imagen de Docker.
2. Subir la imagen a Google Artifact Registry.
3. Desplegar la nueva versión en Cloud Run.
