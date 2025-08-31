resource "google_secret_manager_secret" "secret" {
 secret_id = var.secret_id
 project   = var.project_id

 replication {
   auto {}
 }

}

resource "google_secret_manager_secret_version" "secret-version" {
 secret      = google_secret_manager_secret.secret.id
 secret_data = var.sm_version_data_template

 lifecycle {
   ignore_changes = [
     secret_data,
     enabled
   ]
 }
}
