resource "google_bigquery_job" "bigquery_job" {
  project = var.project_id
  location = var.region

  job_id  = var.bq_job_id

  query {
    query = var.bq_job_query
    use_query_cache = var.bq_job_query_cache
    create_disposition = var.bq_job_create_disposition
    write_disposition  = var.bq_job_write_disposition
  }

  # Este bloque de ciclo de vida es importante.
  # Le dice a Terraform que ignore los cambios en el atributo 'job_id',
  # que se genera nuevo en cada ejecución debido a timestamp().
  # Esto evita que el job de entrenamiento se vuelva a lanzar en cada terraform apply.
  count = var.bq_job_lifecycle_ignore_changes_active ? 1 : 0
  lifecycle {
    ignore_changes = [job_id]
  }
}