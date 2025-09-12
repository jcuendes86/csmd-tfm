# ==================================================================================
# RECURSO: HABILITACIÓN DE APIS
# Habilita un conjunto de APIs de Google Cloud para el proyecto especificado.
# ==================================================================================
resource "google_project_service" "apis_to_enable" {
  # Itera sobre la lista de APIs proporcionada en la variable 'apis'.
  for_each = toset(var.apis)
  
  project  = var.project_id
  service  = "${each.value}.googleapis.com"

  # Las APIs se deshabilitan al destruir los recursos.
  disable_on_destroy = true
  # Deshabilita los servicios dependientes al deshabilitar este servicio.
  disable_dependent_services = true
}