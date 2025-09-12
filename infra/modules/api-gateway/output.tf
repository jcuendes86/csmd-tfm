# ==================================================================================
# SALIDA: URL DEL API GATEWAY
# Expone la URL por defecto del API Gateway creado.
# ==================================================================================
output "url" {
  description = "URL del API Gateway."
  value       = google_api_gateway_gateway.api_gateway.default_hostname
}