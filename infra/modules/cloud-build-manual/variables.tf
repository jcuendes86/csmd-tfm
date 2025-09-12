# ==================================================================================
# VARIABLES PARA EL MÓDULO CLOUD BUILD MANUAL
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

variable "cb_trigger_name" {
  description = "Nombre del trigger de Cloud Build."
  type        = string
}

variable "cb_trigger_filename" {
  description = "Ruta al fichero de configuración de la compilación (cloudbuild.yaml)."
  type        = string
}

variable "cb_repo_uri" {
  description = "URI del repositorio de código fuente."
  type        = string
}

variable "cb_repo_ref" {
  description = "Referencia (rama, tag, etc.) del repositorio."
  type        = string
}

variable "cb_service_account_email" {
  description = "Email de la cuenta de servicio que utilizará Cloud Build."
  type        = string
}

# ---------------------------------
# Variables Opcionales
# ---------------------------------

variable "cb_trigger_description" {
  description = "Descripción del trigger de Cloud Build."
  type        = string
  default     = "Ejecuta el pipeline de Dataflow mediante una plantilla Flex"
}

variable "cb_repo_type" {
  description = "Tipo de repositorio de código fuente."
  type        = string
  default     = "GITHUB"
}

variable "cb_trigger_substitutions" {
  description = "Mapa de sustituciones para pasar a la compilación."
  type        = map(string)
  default     = {}
}

