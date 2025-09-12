# ==================================================================================
# SALIDA: NOMBRE DEL SERVICIO DE CLOUD RUN
# Expone el nombre del servicio de Cloud Run creado.
# ==================================================================================
output "cr_service_name" {
  description = "Nombre del servicio de Cloud Run."
  value       = google_cloud_run_service.service.name
}

# ==================================================================================
# SALIDA: URL DEL SERVICIO DE CLOUD RUN
# Expone la URL del servicio de Cloud Run desplegado.
# ==================================================================================
output "cr_url" {
  description = "URL del servicio de Cloud Run."
  value       = google_cloud_run_service.service.status[0].url
}
