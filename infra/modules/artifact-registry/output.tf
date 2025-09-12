# ==================================================================================
# SALIDA: NOMBRE DEL REPOSITORIO DE ARTIFACT REGISTRY
# Expone el nombre completo del repositorio de Artifact Registry creado.
# ==================================================================================
output "artifact-registry-name" {
  description = "Nombre del repositorio de Artifact Registry."
  value       = google_artifact_registry_repository.repo.name
}