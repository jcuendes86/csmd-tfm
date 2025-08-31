// Habilitar APIs
module "apis" {
  source = "./modules/apis"

  project_id = var.project_id
}

// Configuracion red
module "network" {
  source = "./modules/network"

  project_id = var.project_id
  region     = var.region
  vpc_name   = "${var.project_id}-custom-network"

  depends_on = [
    module.apis
  ]
}

// Crear bucket y subir el dataset de coches de segunda mano
module "bucket_cars_dataset" {
  source = "./modules/storage"

  project_id   = var.project_id
  bucket_name = "${var.project_id}-cars-dataset"
  bucket_location = var.region

  bucket_with_object   = true
  bucket_object_name   = "coches-segunda-mano.csv"
  bucket_object_source = "${path.root}/resources/coches-segunda-mano.csv"

  depends_on = [
    module.apis
  ]

}

// Crear bucket para los templates de Dataflow
module "bucket_dataflow_templates" {
  source = "./modules/storage"

  project_id   = var.project_id
  bucket_name = "${var.project_id}-dataflow-templates"
  bucket_location = var.region

  depends_on = [
    module.apis
  ]
}

// Crear bucket para los trabajos en Dataflow
module "bucket_dataflow_jobs" {
  source = "./modules/storage"

  project_id   = var.project_id
  bucket_name = "${var.project_id}-dataflow-jobs"
  bucket_location = var.region

  bucket_with_soft_delete = true
  bucket_retention_duration_seconds = 0

  bucket_with_lifecycle_rule = true
  bucket_lifecycle_rule_action_type = "Delete"
  bucket_lifecycle_rule_age = 1 # Días para eliminar los objetos temporales y objetos de staging
  bucket_lifecycle_rule_matches_prefix = ["temp/", "staging/"]

  depends_on = [
    module.apis
  ]
}

// Creacion de dataset y tabla de bigQuery
module "bigquey" {
  source = "./modules/bigquery"

  project_id   = var.project_id
  bq_dataset_id = "cars_sales_dataset"
  bq_table_id = "cars_sales"
  bq_table_deletion_protection = false

  depends_on = [
    module.apis
  ]
}

// Cuenta de servicio para trabajos en Dataflow
module "sa-dataflow-worker" {
  source = "./modules/service-account"

  project_id = var.project_id
  sa_account_id = "dataflow-etl-runner"
  sa_display_name = "Dataflow ETL Runner SA"
  sa_roles = [
    "roles/dataflow.worker",
    "roles/storage.objectAdmin",
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    "roles/artifactregistry.writer"
  ]

  depends_on = [
    module.apis
  ]
}

// Cuenta de servicio para Cloud Build
module "sa-cloud-build" {
  source = "./modules/service-account"

  project_id = var.project_id

  sa_account_id = "cloud-build"
  sa_display_name = "Cloud Build SA"
  sa_roles = [
    "roles/cloudbuild.builds.editor",
    "roles/logging.logWriter",
    "roles/artifactregistry.writer",
    "roles/storage.objectAdmin",
    "roles/dataflow.admin",
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    "roles/iam.serviceAccountUser"
  ]

  depends_on = [
    module.apis
  ]
}

// Creacion del repositorio para la imagen Docker del pipeline de Dataflow
module "artifact-registry" {
  source = "./modules/artifact-registry"

  project_id = var.project_id
  region = var.region
  artifact_registry_naming = "dataflow-templates-repo"

  depends_on = [
    module.apis
  ]
}

// Creacion del trigger en Cloud Build para construir la imagen Docker del pipeline de Dataflow
module "cloud-build-dataflow-build-image" {
  source = "./modules/cloud-build"

  project_id                           = var.project_id
  region                               = var.region

  cloud_build_trigger_name             = "cb-dataflow-pipeline-image-builder"
  cloud_build_trigger_filename         = "backend/dataflow-etl-pipeline/cloudbuild.yaml"
  cloud_build_trigger_repository_owner = "jcuendes86"
  cloud_build_trigger_repository_name  = "csmd-tfm"

  cloud_build_service_account_email = module.sa-cloud-build.service_account_name

  included_files = ["backend/dataflow-etl-pipeline/**"]

  cloud_build_trigger_substitutions = {
    _TEMPLATE_BUCKET_NAME   = "gs://${module.bucket_dataflow_templates.storage-name}/templates/cars_dataset_pipeline.json"
    _ARTIFACT_REPO_NAME     = module.artifact-registry.artifact-registry-name
    _IMAGE_NAME             = "cars-dataset-pipeline"
    _IMAGE_TAG              = "latest"
    _REGION                 = var.region
    _NETWORK_NAME           = module.network.network_name
    _SUBNETWORK_NAME        = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/regions/europe-southwest1/subnetworks/${module.network.network_name}"
    _STAGING_BUCKET_NAME    = "gs://${module.bucket_dataflow_jobs.storage-name}/staging"
    _TEMP_BUCKET_NAME       = "gs://${module.bucket_dataflow_jobs.storage-name}/temp"
    _SERVICE_ACCOUNT_EMAIL  = module.sa-dataflow-worker.service_account_email
  }

  depends_on = [
    module.apis,
    module.network,
    module.bucket_dataflow_templates,
    module.bucket_dataflow_jobs,
    module.artifact-registry,
    module.sa-cloud-build,
    module.sa-dataflow-worker,
  ]
}

# Crear el trigger de Cloud Build para ejecutar el job de Dataflow
module "cloud-build-dataflow-run-job" {
  source = "./modules/cloud-build"

  project_id                           = var.project_id
  region                               = var.region

  cloud_build_trigger_name             = "cb-dataflow-flex-template-runner"
  cloud_build_trigger_filename         = "backend/dataflow-etl-pipeline/dataflow_job.yaml"
  cloud_build_trigger_repository_owner = "jcuendes86"
  cloud_build_trigger_repository_name  = "csmd-tfm"

  cloud_build_service_account_email = module.sa-cloud-build.service_account_name

  cloud_build_trigger_regex_branch = "never-trigger"

  cloud_build_trigger_substitutions = {
    _REGION                 = "europe-southwest1"
    _TEMPLATE_BUCKET_NAME   = "gs://${module.bucket_dataflow_templates.storage-name}/templates/cars_dataset_pipeline.json"
    _DATASET_BUCKET_NAME    = "gs://${module.bucket_cars_dataset.storage-name}/coches-segunda-mano.csv"
    _STAGING_BUCKET_NAME    = "gs://${module.bucket_dataflow_jobs.storage-name}/staging"
    _TEMP_BUCKET_NAME       = "gs://${module.bucket_dataflow_jobs.storage-name}/temp"
    _BQ_DATASET             = module.bigquey.dataset
    _BQ_TABLE               = module.bigquey.table
    _DATAFLOW_WORKER_SA_EMAIL = module.sa-dataflow-worker.service_account_email
  }

  depends_on = [
    module.apis,
    module.network,
    module.bucket_cars_dataset,
    module.bucket_dataflow_templates,
    module.bucket_dataflow_jobs,
    module.bigquey,
    module.sa-dataflow-worker,
    module.sa-cloud-build
  ]
}

// Creacion del modelo de predicción en BigQuery ML
module "train_cars_prediction_model" {
  source = "./modules/bigquery-model"

  project_id   = var.project_id
  region       = "EU"

  bq_job_id    = "train_cars_prediction_model_${formatdate("YYYYMMDDhhmmss", timestamp())}"
  bq_job_query = <<-EOT
      CREATE OR REPLACE MODEL ${module.bigquey.dataset}.cars_prediction_model
      OPTIONS(
        MODEL_TYPE='BOOSTED_TREE_REGRESSOR',
        INPUT_LABEL_COLS=['log_price'],

        -- Objetivo de tuning
        NUM_TRIALS=25,
        MAX_PARALLEL_TRIALS=3,
        HPARAM_TUNING_OBJECTIVES=['R2_SCORE'],

        -- Espacio de búsqueda
        LEARN_RATE=HPARAM_RANGE(0.02, 0.20),
        MAX_TREE_DEPTH=HPARAM_CANDIDATES([4,6,8,10,12]),
        L1_REG=HPARAM_RANGE(0.0, 0.5),
        L2_REG=HPARAM_RANGE(0.5, 5.0),

        -- Entrenamiento / split
        EARLY_STOP=TRUE,
        MAX_ITERATIONS=600
      ) AS
      SELECT
        make, model, fuel, year, kms, power, doors, shift,
        color, province, country, LOG(price) as log_price
      FROM
        `${var.project_id}.${module.bigquey.dataset}.${module.bigquey.table}`
    EOT

  # Es importante deshabilitar el uso de caché para las consultas CREATE MODEL
  # para asegurar que el entrenamiento se ejecute siempre que se apliquen los cambios.
  bq_job_query_cache = false

  # Para las consultas DDL como CREATE MODEL, es necesario especificar que no hay
  # una disposición de creación o escritura, ya que no se está creando una tabla de destino.
  # Esto evita el error "Cannot set create disposition...".
  bq_job_create_disposition = ""
  bq_job_write_disposition  = ""

  bq_job_lifecycle_ignore_changes_active = true

  depends_on = [
    module.apis,
    module.bigquey
  ]
}

// Creaccion del secret manager para las API de Cloud Run
module "sm_cr_secrets" {
  source = "./modules/secret-manager"

  project_id              = var.project_id
  secret_id               = "sm-cars-prediction-api"
  sm_replication_location = var.region

  sm_version_data_template = <<-EOT
    # Host to deploy the service
    SERVER_HOST='0.0.0.0'

    # Port to deploy the service
    SERVER_PORT=8080

    # Control check token of header object
    TOKEN_HEADER_XFROM='x-from:secure-header'

    # Google Cloud
    # Name of the project in gcloud
    GOOGLE_CLOUD_PROJECT='${var.project_id}'

    # Name of the BigQuery dataset
    BQ_DATASET_NAME='${module.bigquey.dataset}'

    # Name of the BigQuery ML model
    BQ_ML_MODEL_NAME='cars_prediction_model'
  EOT

  depends_on = [ 
    module.apis,
    module.bigquey
  ]
}

// Cuenta de servicio para Cloud Run
module "sa-cloud-run" {
  source = "./modules/service-account"

  project_id = var.project_id

  sa_account_id = "cloud-run"
  sa_display_name = "Cloud Run SA"
  sa_roles = [
    "roles/cloudbuild.builds.editor",
    "roles/logging.logWriter",
    "roles/run.invoker",
    "roles/secretmanager.secretAccessor"
  ]

  depends_on = [
    module.apis
  ]
}

// Creacion del servicio de Cloud Run para la API de predicción de coches
module "cloud-run-cars-prediction-api" {
  source = "./modules/cloud-run"

  service_name        = "cars-prediction-api"
  region              = var.region

  cr_service_account  = module.sa-cloud-run.service_account_email

  volume_name         = "env-vars-volume"
  secret_name         = module.sm_cr_secrets.sm_secret_id
  volume_mount_path   = "/cars-prediction-api/env"

  cr_container_limit_cpu    = "1"
  cr_container_limit_memory = "1Gi"

  cr_max_instances   = "1"
  cr_min_instances   = "0"
  cr_vpc_ingress     = "internal"

  depends_on = [
    module.apis,
    module.sa-cloud-run,
    module.sm_cr_secrets
  ]
}

// Creacion del repositorio para la imagen Docker de la API de prediccion
module "artifact-registry-api" {
  source = "./modules/artifact-registry"

  project_id = var.project_id
  region = var.region
  artifact_registry_naming = "cars-prediction-api-repo"

  depends_on = [
    module.apis
  ]
}

// Creacion del trigger en Cloud Build para construir y subir la imagen Docker de la API
module "cloud-build-cars-prediction-api" {
  source = "./modules/cloud-build"

  project_id                           = var.project_id
  region                               = var.region

  cloud_build_trigger_name             = "cb-cars-prediction-api-image-builder"
  cloud_build_trigger_filename         = "backend/cars-prediction-api/cloudbuild.yaml"
  cloud_build_trigger_repository_owner = "jcuendes86"
  cloud_build_trigger_repository_name  = "csmd-tfm"

  cloud_build_service_account_email = module.sa-cloud-build.service_account_name

  included_files = ["backend/cars-prediction-api/**"]

  cloud_build_trigger_substitutions = {
    _ARTIFACT_REPO_NAME     = module.artifact-registry-api.artifact-registry-name
    _IMAGE_NAME             = "cars-prediction-api"
    _IMAGE_TAG              = "latest"
    _REGION                 = var.region
    _SERVICE_NAME           = module.cloud-run-cars-prediction-api.cr_service_name
  }

  depends_on = [
    module.apis,
    module.artifact-registry-api,
    module.sa-cloud-build,
    module.cloud-run-cars-prediction-api
  ]
}
