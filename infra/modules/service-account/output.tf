# ==================================================================================
# SALIDA: EMAIL DE LA CUENTA DE SERVICIO
# Expone el email de la cuenta de servicio creada.
# ==================================================================================
output "service_account_email" {
  description = "Email de la cuenta de servicio."
  value       = google_service_account.service_account.email
}

# ==================================================================================
# SALIDA: NOMBRE DE LA CUENTA DE SERVICIO
# Expone el nombre completo de la cuenta de servicio creada.
# ==================================================================================
output "service_account_name" {
  description = "Nombre de la cuenta de servicio."
  value       = google_service_account.service_account.name
}