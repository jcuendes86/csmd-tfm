# ==================================================================================
# VARIABLES PARA EL MÓDULO CLOUD BUILD
# ==================================================================================

# ---------------------------------
# Variables Requeridas
# ---------------------------------

variable "project_id" {
  description = "ID del proyecto de Google Cloud al que pertenece el recurso."
  type        = string
}

variable "region" {
  description = "Región donde se desplegarán los recursos."
  type        = string
}

variable "cloud_build_trigger_name" {
  description = "Nombre del trigger de Cloud Build."
  type        = string
}

variable "cloud_build_trigger_filename" {
  description = "Ruta al fichero de configuración de la compilación (cloudbuild.yaml)."
  type        = string
}

variable "cloud_build_trigger_repository_owner" {
  description = "Propietario del repositorio de GitHub."
  type        = string
}

variable "cloud_build_trigger_repository_name" {
  description = "Nombre del repositorio de GitHub."
  type        = string
}

variable "cloud_build_service_account_email" {
  description = "Email de la cuenta de servicio que utilizará Cloud Build."
  type        = string
}

# ---------------------------------
# Variables Opcionales
# ---------------------------------

variable "cloud_build_trigger_description" {
  description = "Descripción del trigger de Cloud Build."
  type        = string
  default     = "Construye la plantilla de Dataflow al hacer push a la rama main en GitHub."
}

variable "cloud_build_trigger_regex_branch" {
  description = "Expresión regular para la rama que activará el trigger."
  type        = string
  default     = "^main$"
}

variable "cloud_build_trigger_substitutions" {
  description = "Mapa de sustituciones para pasar a la compilación."
  type        = map(string)
  default     = {}
}

variable "included_files" {
  description = "Lista de ficheros que, si se modifican, activarán el trigger."
  type        = list(string)
  default     = []
}

