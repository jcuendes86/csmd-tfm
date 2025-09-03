resource "google_cloudbuild_trigger" "cb_manual_trigger" {
  project     = var.project_id
  name        = var.cb_trigger_name
  description = var.cb_trigger_description
  location    = var.region

  source_to_build {
    uri       = var.cb_repo_uri
    ref       = var.cb_repo_ref
    repo_type = var.cb_repo_type
  }

  git_file_source {
    path      = var.cb_trigger_filename
    uri       = var.cb_repo_uri
    revision  = var.cb_repo_ref
    repo_type = var.cb_repo_type
  }

  service_account = var.cb_service_account_email

  substitutions = var.cb_trigger_substitutions
}
