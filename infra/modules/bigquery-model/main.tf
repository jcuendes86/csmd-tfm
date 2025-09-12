# ==================================================================================
# RECURSO: TRABAJO (JOB) DE BIGQUERY
# Define y ejecuta un trabajo en BigQuery, generalmente para ejecutar una consulta
# de larga duración como el entrenamiento de un modelo de ML.
# ==================================================================================
resource "google_bigquery_job" "bigquery_job" {
  project  = var.project_id
  location = var.region

  job_id   = var.bq_job_id

  query {
    query              = var.bq_job_query
    use_query_cache    = var.bq_job_query_cache
    create_disposition = var.bq_job_create_disposition
    write_disposition  = var.bq_job_write_disposition
  }

  # ==================================================================================
  # CICLO DE VIDA
  # Este bloque es crucial para evitar que Terraform intente recrear el trabajo
  # en cada ejecución. Al ignorar los cambios en 'job_id' (que puede ser único
  # en cada apply), se asegura que el trabajo de entrenamiento no se lance
  # repetidamente sin necesidad.
  # ==================================================================================
  # La variable 'count' permite activar o desactivar este comportamiento.
  count = var.bq_job_lifecycle_ignore_changes_active ? 1 : 0
  lifecycle {
    ignore_changes = [job_id]
  }
}