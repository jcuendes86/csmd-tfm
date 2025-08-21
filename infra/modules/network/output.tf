output "network" {
  description = "VPC Network object"
  value       = google_compute_network.custom-network
}

output "network_name" {
  description = "VPC Network name"
  value       = google_compute_network.custom-network.name
}
