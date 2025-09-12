# ==================================================================================
# RECURSO: TRIGGER DE CLOUD BUILD
# Crea un trigger en Cloud Build que se activa con un push a una rama específica
# de un repositorio de GitHub.
# ==================================================================================
resource "google_cloudbuild_trigger" "cb_trigger" {
  project         = var.project_id
  location        = var.region
  name            = var.cloud_build_trigger_name
  description     = var.cloud_build_trigger_description

  # Cuenta de servicio que utilizará el trigger para ejecutar las compilaciones.
  service_account = var.cloud_build_service_account_email

  # Fichero de configuración de la compilación y variables de sustitución.
  filename        = var.cloud_build_trigger_filename
  substitutions   = var.cloud_build_trigger_substitutions

  # Ficheros que, si se modifican, activarán el trigger.
  included_files  = var.included_files

  # Configuración del repositorio de GitHub.
  github {
    owner = var.cloud_build_trigger_repository_owner
    name  = var.cloud_build_trigger_repository_name
    push {
      branch = var.cloud_build_trigger_regex_branch
    }
  }
}