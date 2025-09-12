# ==================================================================================
# SALIDA: OBJETO DE RED VPC
# Expone el objeto completo de la red VPC creada.
# ==================================================================================
output "network" {
  description = "Objeto de la red VPC."
  value       = google_compute_network.custom-network
}

# ==================================================================================
# SALIDA: NOMBRE DE LA RED VPC
# Expone el nombre de la red VPC creada.
# ==================================================================================
output "network_name" {
  description = "Nombre de la red VPC."
  value       = google_compute_network.custom-network.name
}
