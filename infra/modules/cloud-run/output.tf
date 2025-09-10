output "cr_service_name" {
 description = "Clour Run service name"
 value       = google_cloud_run_service.service.name
}

output "cr_url" {
 description = "Cloud Run service URL"
 value       = google_cloud_run_service.service.status[0].url
}
