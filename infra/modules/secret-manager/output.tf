output "sm_secret_id" {
 description = "Secret identifier"
 value       = google_secret_manager_secret.secret.secret_id
}

output "sm_secret_version_id" {
 description = "Secret version identifier"
 value       = google_secret_manager_secret_version.secret-version.id
}