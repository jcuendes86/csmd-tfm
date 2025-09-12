# ==================================================================================
# SALIDA: API KEY
# Expone el valor de la API Key creada. Se marca como sensible para evitar que se
# muestre en los logs.
# ==================================================================================
output "api_key_string" {
  description = "Valor de la API Key."
  value       = try(google_apikeys_key.api_key.key_string, null)
  sensitive   = true
}