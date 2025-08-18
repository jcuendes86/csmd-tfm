output "service_account_email" {
  description = "Service account email"
  value = google_service_account.service_account.email
}

output "service_account_name" {
  description = "Service account name"
  value = google_service_account.service_account.name
}