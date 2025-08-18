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
  subnetwork_name = "${var.project_id}-subnetwork"
  vpc_delete_default_routes_on_create = true

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
    "roles/bigquery.jobUser"
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
    "roles/artifactregistry.writer"
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

// Creacion del trigger en Cloud Build
module "cloud-build" {
  source = "./modules/cloud-build"

  project_id                           = var.project_id
  region                               = var.region

  cloud_build_trigger_name             = "cb-dataflow-pipeline-image-builder"
  cloud_build_trigger_filename         = "backend/dataflow-etl-pipeline/cloudbuild.yaml"
  cloud_build_trigger_repository_owner = "jcuendes86"
  cloud_build_trigger_repository_name  = "csmd-tfm"

  cloud_build_service_account_email = module.sa-cloud-build.service_account_name

  cloud_build_trigger_substitutions = {
    _BUCKET_NAME        = "gs://${module.bucket_dataflow_templates.storage-name}/templates/cars_dataset_pipeline.json"
    _ARTIFACT_REPO_NAME = module.artifact-registry.artifact-registry-name
    _IMAGE_NAME         = "cars-dataset-pipeline"
    _IMAGE_TAG          = "latest"
    _REGION             = var.region
    _NETWORK_NAME       = module.network.network_name
    _STAGING_BUCKET_NAME = "gs://${module.bucket_dataflow_jobs.storage-name}/staging"
    _TEMP_BUCKET_NAME   = "gs://${module.bucket_dataflow_jobs.storage-name}/temp"
    _SERVICE_ACCOUNT_EMAIL = module.sa-dataflow-worker.service_account_email
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