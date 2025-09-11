resource "google_api_gateway_api" "api" {
    provider = google-beta

    project   = var.project_id
    api_id     = var.api_id
}

resource "google_api_gateway_api_config" "api_config" {
    provider = google-beta

    project   = var.project_id
    api             = var.api_id
    api_config_id   = "${var.api_id}-config"

    gateway_config {
        backend_config {
            google_service_account = var.api_config_sa_email
        }
    }

    openapi_documents {
        document {
            path     = var.openapi_file_path
            contents = base64encode(
                templatefile(var.openapi_file_path, { 
                    API_TITLE = var.api_id,
                    CLOUD_RUN_URL = var.cloud_run_url,
                    })
            )
        }
    }

    depends_on = [ 
        google_api_gateway_api.api
    ]
}

resource "google_api_gateway_gateway" "api_gateway" {
    provider = google-beta

    project   = var.project_id
    gateway_id    = "${var.api_id}-gateway"
    api_config    = google_api_gateway_api_config.api_config.name
    region        = var.region

    depends_on = [
        google_api_gateway_api.api,
        google_api_gateway_api_config.api_config
    ]
}