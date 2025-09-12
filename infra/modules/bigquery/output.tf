# ==================================================================================
# SALIDA: NOMBRE DEL DATASET
# Expone el ID del dataset de BigQuery creado.
# ==================================================================================
output "dataset" {
  description = "Nombre del dataset de BigQuery."
  value       = google_bigquery_dataset.dataset.dataset_id
}

# ==================================================================================
# SALIDA: NOMBRE DE LA TABLA
# Expone el ID de la tabla de BigQuery creada.
# ==================================================================================
output "table" {
  description = "Nombre de la tabla de BigQuery."
  value = google_bigquery_table.table.table_id
}