# ==================================================================================
# VARIABLES REQUERIDAS PARA EL MÓDULO APIS
# ==================================================================================

# ---------------------------------
# Configuración Global
# ---------------------------------

variable "project_id" {
  description = "ID del proyecto de Google Cloud donde se habilitarán las APIs."
  type        = string
}

# ---------------------------------
# Configuración de APIs
# ---------------------------------

variable "apis" {
  description = "Lista de APIs que se habilitarán en el proyecto."
  type        = list(string)
  default     = [
    "apigateway",
    "apikeys",
    "artifactregistry",
    "cloudbuild",
    "compute",
    "dataflow",
    "iam",
    "run",
    "secretmanager",
    "servicecontrol",
  ]
}