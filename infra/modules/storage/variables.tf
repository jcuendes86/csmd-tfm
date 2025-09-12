# ==================================================================================
# VARIABLES PARA EL MÓDULO STORAGE
# ==================================================================================

# ---------------------------------
# Variables Requeridas
# ---------------------------------

variable "project_id" {
  description = "ID del proyecto de Google Cloud."
  type        = string
}

variable "bucket_name" {
  description = "Nombre del bucket de Cloud Storage."
  type        = string
}

variable "bucket_location" {
  description = "Ubicación del bucket (regional, multirregional, etc.)."
  type        = string
}

# ---------------------------------
# Variables Opcionales
# ---------------------------------

variable "bucket_force_destroy" {
  description = "Si es true, se eliminarán todos los objetos del bucket al destruirlo."
  type        = bool
  default     = true
}

variable "bucket_uniform_bucket_level_access" {
  description = "Habilita el acceso uniforme a nivel de bucket."
  type        = bool
  default     = true
}

variable "bucket_public_access_prevention" {
  description = "Previene el acceso público al bucket. Valores: 'inherited' o 'enforced'."
  type        = string
  default     = "inherited"
}

variable "bucket_class" {
  description = "Clase de almacenamiento del bucket (STANDARD, NEARLINE, etc.)."
  type        = string
  default     = "STANDARD"
}

variable "bucket_with_soft_delete" {
  description = "Habilita la política de eliminación suave (soft delete) en el bucket."
  type        = bool
  default     = false
}

variable "bucket_retention_duration_seconds" {
  description = "Duración en segundos de la política de retención para la eliminación suave."
  type        = number
  default     = 0
}

variable "bucket_with_lifecycle_rule" {
  description = "Habilita una regla de ciclo de vida para los objetos del bucket."
  type        = bool
  default     = false
}

variable "bucket_lifecycle_rule_action_type" {
  description = "Tipo de acción para la regla de ciclo de vida (por ejemplo, 'Delete')."
  type        = string
  default     = ""
}

variable "bucket_lifecycle_rule_age" {
  description = "Antigüedad en días para que se aplique la regla de ciclo de vida."
  type        = number
  default     = 0
}

variable "bucket_lifecycle_rule_matches_prefix" {
  description = "Prefijos que deben coincidir para que se aplique la regla de ciclo de vida."
  type        = list(string)
  default     = []
}

variable "bucket_with_object" {
  description = "Si es true, se subirá un objeto al bucket."
  type        = bool
  default     = false
}

variable "bucket_object_name" {
  description = "Nombre del objeto que se subirá al bucket."
  type        = string
  default     = ""
}

variable "bucket_object_source" {
  description = "Ruta local del fichero que se subirá como objeto."
  type        = string
  default     = ""
}
