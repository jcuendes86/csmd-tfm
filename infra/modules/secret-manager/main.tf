# ==================================================================================
# RECURSO: SECRETO DE SECRET MANAGER
# Crea un secreto en Google Cloud Secret Manager para almacenar datos sensibles.
# ==================================================================================
resource "google_secret_manager_secret" "secret" {
  secret_id = var.secret_id
  project   = var.project_id

  # Configura la replicación automática del secreto.
  replication {
    auto {}
  }
}

# ==================================================================================
# RECURSO: VERSIÓN DEL SECRETO
# Añade una nueva versión al secreto con los datos especificados.
# ==================================================================================
resource "google_secret_manager_secret_version" "secret-version" {
  secret      = google_secret_manager_secret.secret.id
  secret_data = var.sm_version_data_template

  # ==================================================================================
  # CICLO DE VIDA
  # Ignora los cambios en los datos del secreto y su estado de habilitación.
  # Esto permite que el valor del secreto sea gestionado fuera de Terraform sin
  # que Terraform intente revertir los cambios.
  # ==================================================================================
  lifecycle {
    ignore_changes = [
      secret_data,
      enabled
    ]
  }
}
