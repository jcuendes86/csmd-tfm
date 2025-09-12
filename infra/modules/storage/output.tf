# ==================================================================================
# SALIDA: NOMBRE DEL BUCKET
# Expone el nombre del bucket de Cloud Storage creado.
# ==================================================================================
output "storage-name" {
  description = "Nombre del bucket de Cloud Storage."
  value       = google_storage_bucket.bucket.name
}