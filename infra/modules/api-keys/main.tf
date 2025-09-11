resource "google_apikeys_key" "api_key" {
    project      = var.project_id
    name         = var.apikeys_name
    display_name = var.apikeys_display_name
  

    restrictions {
      api_targets {
        service = var.managed_service
      }
    }

    lifecycle {
      ignore_changes = [ 
        restrictions[0].api_targets[0].service
       ]
    }
}