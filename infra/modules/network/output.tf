output "network" {
  description = "VPC Network object"
  value       = google_compute_network.custom-network
}

output "network_name" {
  description = "VPC Network name"
  value       = google_compute_network.custom-network.name
}

output "subnetwork" {
  description = "VPC Subnetwork object"
  value       = google_compute_subnetwork.custom-subnetwork
}

output "subnetwork_self_link" {
  description = "VPC Subnetwork self link"
  value       = google_compute_subnetwork.custom-subnetwork.self_link
}
