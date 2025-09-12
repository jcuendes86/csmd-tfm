# ==================================================================================
# RECURSO: TRIGGER MANUAL DE CLOUD BUILD
# Crea un trigger en Cloud Build que se puede invocar manualmente.
# ==================================================================================
resource "google_cloudbuild_trigger" "cb_manual_trigger" {
  project         = var.project_id
  name            = var.cb_trigger_name
  description     = var.cb_trigger_description
  location        = var.region

  # Define la fuente del código a construir.
  source_to_build {
    uri       = var.cb_repo_uri
    ref       = var.cb_repo_ref
    repo_type = var.cb_repo_type
  }

  # Define el fichero de configuración de la compilación.
  git_file_source {
    path      = var.cb_trigger_filename
    uri       = var.cb_repo_uri
    revision  = var.cb_repo_ref
    repo_type = var.cb_repo_type
  }

  # Cuenta de servicio que utilizará el trigger.
  service_account = var.cb_service_account_email

  # Variables de sustitución para la compilación.
  substitutions   = var.cb_trigger_substitutions
}
