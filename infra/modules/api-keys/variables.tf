# ==================================================================================
# VARIABLES REQUERIDAS PARA EL MÓDULO API KEYS
# ==================================================================================

variable "project_id" {
  description = "ID del proyecto de Google Cloud al que pertenece el recurso."
  type        = string
}

variable "apikeys_name" {
  description = "Nombre de la API Key."
  type        = string
}

variable "apikeys_display_name" {
  description = "Nombre para mostrar de la API Key."
  type        = string
}

variable "managed_service" {
  description = "Nombre del servicio gestionado al que se asociará la API Key."
  type        = string
}
