# ==================================================================================
# RECURSO: REPOSITORIO DE ARTIFACT REGISTRY
# Crea un repositorio en Artifact Registry para almacenar artefactos como imágenes
# de Docker.
# ==================================================================================
resource "google_artifact_registry_repository" "repo" {
  project       = var.project_id
  location      = var.region
  repository_id = var.artifact_registry_naming
  description   = var.artifact_registry_description
  format        = var.artifact_format
}
