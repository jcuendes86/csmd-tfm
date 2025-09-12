# ==================================================================================
# VARIABLES PARA EL MÓDULO ARTIFACT REGISTRY
# ==================================================================================

# ---------------------------------
# Variables Requeridas
# ---------------------------------

variable "project_id" {
  description = "ID del proyecto de Google Cloud al que pertenece el recurso."
  type        = string
}

variable "region" {
  description = "Ubicación donde se creará el repositorio."
  type        = string
}

variable "artifact_registry_naming" {
  description = "Identificador único del repositorio (la parte final del nombre)."
  type        = string
}

# ---------------------------------
# Variables Opcionales
# ---------------------------------

variable "artifact_registry_description" {
  description = "Descripción del repositorio."
  type        = string
  default     = "Repositorio para las imágenes de las plantillas de Dataflow."
}

variable "artifact_format" {
  description = "Formato de los paquetes que se almacenarán en el repositorio."
  type        = string
  default     = "DOCKER"
}
