# Infraestructura como Código (IaC) - TFM

Este directorio contiene toda la configuración de la infraestructura como código (IaC) para el proyecto del TFM, gestionada con Terraform.

## Descripción

El código de este directorio se encarga de aprovisionar y gestionar todos los recursos necesarios en Google Cloud Platform (GCP) para el despliegue de la aplicación, el pipeline de datos y los modelos de machine learning.

## Requisitos Previos

Antes de poder ejecutar este código, necesitas tener instalado y configurado lo siguiente:

1.  **Terraform:** [Instrucciones de instalación](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2.  **Google Cloud SDK:** [Instrucciones de instalación](https://cloud.google.com/sdk/docs/install)
3.  **Autenticación en GCP:** Debes autenticarte en tu cuenta de Google Cloud. La forma más sencilla es a través del CLI:
    ```bash
    gcloud auth application-default login
    ```
    Además, asegúrate de que tengas permisos para que terraform pueda crear los recursos en tu cuenta de GCP.

## Estructura de Archivos

-   `main.tf`: Fichero principal que orquesta el despliegue de todos los módulos.
-   `variables.tf`: Define las variables de entrada para la configuración de Terraform (ej: `project_id`, `region`).
-   `provider.tf`: Configura el proveedor de Google Cloud para Terraform.
-   `modules/`: Contiene los módulos reutilizables de Terraform, cada uno responsable de un conjunto específico de recursos.
-   `resources/`: Almacena ficheros adicionales necesarios para la infraestructura, como datasets iniciales.

## Uso

Para desplegar la infraestructura, sigue estos pasos desde el directorio `infra`:

1.  **Inicializar Terraform:**
    Prepara el directorio de trabajo, descargando los proveedores y módulos necesarios.
    ```bash
    terraform init
    ```

2.  **Planificar los cambios:**
    Crea un plan de ejecución que te mostrará los recursos que se crearán, modificarán o destruirán.
    ```bash
    terraform plan
    ```

3.  **Aplicar los cambios:**
    Aprovisiona la infraestructura en GCP según el plan. Se te pedirá confirmación antes de proceder.
    ```bash
    terraform apply
    ```

Para destruir la infraestructura y eliminar todos los recursos creados:

```bash
terraform destroy
```

## Módulos

Este proyecto utiliza los siguientes módulos de Terraform para organizar los recursos:

-   `api-gateway`: Gestiona la configuración de API Gateway para exponer los servicios de forma segura.
-   `api-keys`: Crea y gestiona las claves de API necesarias para acceder a los servicios.
-   `apis`: Habilita las APIs de GCP requeridas por el proyecto.
-   `artifact-registry`: Crea un repositorio en Artifact Registry para almacenar las imágenes de Docker.
-   `bigquery`: Aprovisiona los datasets y tablas en BigQuery.
-   `bigquery-model`: Despliega el modelo de Machine Learning entrenado en BigQuery ML.
-   `cloud-build`: Configura los triggers de Cloud Build para la integración y despliegue continuo (CI/CD).
-   `cloud-run`: Despliega los servicios de backend como aplicaciones de Cloud Run.
-   `network`: Define la configuración de red (VPC, subredes, etc.).
-   `secret-manager`: Almacena y gestiona secretos como contraseñas o claves de API.
-   `service-account`: Crea las cuentas de servicio con los permisos necesarios para los recursos.
-   `storage`: Crea los buckets de Cloud Storage para el almacenamiento de ficheros.
