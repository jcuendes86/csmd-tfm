# ==================================================================================
# SALIDA: ID DEL SECRETO
# Expone el ID del secreto creado en Secret Manager.
# ==================================================================================
output "sm_secret_id" {
  description = "Identificador del secreto."
  value       = google_secret_manager_secret.secret.secret_id
}

# ==================================================================================
# SALIDA: ID DE LA VERSIÓN DEL SECRETO
# Expone el ID de la versión del secreto creada.
# ==================================================================================
output "sm_secret_version_id" {
  description = "Identificador de la versión del secreto."
  value       = google_secret_manager_secret_version.secret-version.id
}