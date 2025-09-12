# Proyecto de Fin de Máster - Predicción de Precios de Coches de Segunda Mano

## Descripción General

Este proyecto tiene como objetivo la creación de un sistema completo para la predicción de precios de coches de segunda mano. El sistema incluye un pipeline de ETL para el procesamiento de datos, modelo de BigQuery ML para la predicción de precios y una API para la exposición del modelo. La infraestructura del proyecto se gestiona como código utilizando Terraform.

## Estructura del Proyecto

El proyecto se organiza en las siguientes carpetas principales:

-   `backend/`: Contiene el código de las aplicaciones backend, incluyendo la API de predicción y el pipeline de ETL.
-   `infra/`: Contiene la configuración de la infraestructura como código (IaC) utilizando Terraform.
-   `models/`: Contiene los modelos de BigQuery ML que he ido probando durante el desarrollo del TFM, incluyendo los scripts SQL para su creación y entrenamiento y su evaluación.
-   `resources/`: Contiene los recursos de datos utilizados en el proyecto, como el dataset de coches de segunda mano.

### Backend

La carpeta `backend/` se divide en dos subproyectos:

-   `cars-prediction-api/`: Una aplicación Node.js con TypeScript que expone el modelo de predicción de precios a través de una API REST.
-   `dataflow-etl-pipeline/`: Un pipeline de ETL implementado con Apache Beam y Dataflow para el procesamiento y limpieza del dataset de coches.

### Infraestructura

La carpeta `infra/` contiene la configuración de Terraform para la creación y gestión de la infraestructura en la nube. Los módulos de Terraform se utilizan para crear los siguientes recursos:

-   API Gateway
-   API Keys
-   Artifact Registry
-   BigQuery
-   Cloud Build
-   Cloud Run
-   Redes
-   Secret Manager
-   Service Accounts
-   Storage

### Modelos

La carpeta `models/` contiene los modelos de BigQuery ML que he ido probando durante el desarrollo del TFM para la predicción de precios. Se han implementado y probado dos tipos de modelos:

-   `boosted_tree_regressor/`: Un modelo de regresión basado en árboles de decisión con gradient boosting.
-   `random_forest_regressor/`: Un modelo de regresión basado en bosques aleatorios.

Para cada modelo, se incluyen los siguientes scripts SQL:

-   `create_model.sql`: Script para la creación y entrenamiento del modelo en BigQuery ML.
-   `evaluate_model.sql`: Script para la evaluación del modelo.

### Postman

La carpeta `postman/` contiene la colección de peticiones a la API de predicción de precios. Además contiene los resultados de las pruebas realizadas.
