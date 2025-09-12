# ==================================================================================
# VARIABLES REQUERIDAS PARA EL MÓDULO API GATEWAY
# ==================================================================================

variable "project_id" {
  description = "ID del proyecto de Google Cloud al que pertenece el recurso."
  type        = string
}

variable "api_id" {
  description = "ID único para la API de API Gateway dentro del proyecto y la región."
  type        = string
}

variable "region" {
  description = "Región donde se desplegará la instancia de API Gateway."
  type        = string
}

variable "openapi_file_path" {
  description = "Ruta al fichero de especificación OpenAPI (swagger.yaml)."
  type        = string
}

variable "cloud_run_url" {
  description = "URL del servicio de Cloud Run que se utilizará en la especificación OpenAPI."
  type        = string
}

variable "api_config_sa_email" {
  description = "Email de la cuenta de servicio que API Gateway utilizará para firmar el token de ID al llamar al servicio de Cloud Run."
  type        = string
}
