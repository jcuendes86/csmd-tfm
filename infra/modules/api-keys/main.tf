# ==================================================================================
# RECURSO: API KEY
# Crea una API Key de Google Cloud con restricciones específicas.
# ==================================================================================
resource "google_apikeys_key" "api_key" {
    project      = var.project_id
    name         = var.apikeys_name
    display_name = var.apikeys_display_name
  
    # Restringe el uso de la API Key a un servicio específico (managed service).
    restrictions {
      api_targets {
        service = var.managed_service
      }
    }

    # Ignora los cambios en el servicio de destino para evitar recreaciones innecesarias.
    lifecycle {
      ignore_changes = [ 
        restrictions[0].api_targets[0].service
       ]
    }
}