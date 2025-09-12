# ==================================================================================
# VARIABLES PARA EL MÓDULO BIGQUERY MODEL
# ==================================================================================

# ---------------------------------
# Variables Requeridas
# ---------------------------------

variable "project_id" {
  description = "ID del proyecto de Google Cloud donde se ejecutará el trabajo."
  type        = string
}

variable "region" {
  description = "Región donde se crearán los recursos."
  type        = string
}

variable "bq_job_id" {
  description = "ID para el trabajo (job) de BigQuery."
  type        = string
}

variable "bq_job_query" {
  description = "Consulta que se ejecutará en el trabajo de BigQuery."
  type        = string
}

# ---------------------------------
# Variables Opcionales
# ---------------------------------

variable "bq_job_query_cache" {
  description = "Habilita o deshabilita el uso de la caché para la consulta."
  type        = bool
  default     = false
}

variable "bq_job_create_disposition" {
  description = "Especifica la acción a tomar cuando se crea la tabla de destino."
  type        = string
  default     = ""
}

variable "bq_job_write_disposition" {
  description = "Especifica la acción a tomar cuando los datos se escriben en la tabla."
  type        = string
  default     = ""
}

variable "bq_job_lifecycle_ignore_changes_active" {
  description = "Activa o desactiva el bloqueo del ciclo de vida para ignorar cambios en job_id."
  type        = bool
  default     = false
}