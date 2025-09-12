# ==================================================================================
# VARIABLES PARA EL MÓDULO SECRET MANAGER
# ==================================================================================

# ---------------------------------
# Variables Requeridas
# ---------------------------------

variable "project_id" {
  description = "ID del proyecto de Google Cloud al que pertenece el recurso."
  type        = string
}

variable "secret_id" {
  description = "ID del secreto. Debe ser único dentro del proyecto."
  type        = string
}

# ---------------------------------
# Variables Opcionales
# ---------------------------------

variable "sm_version_data_template" {
  description = "Plantilla con los datos que se añadirán como una nueva versión del secreto."
  default     = null
}

variable "sm_members_admins" {
  description = "Lista de miembros (cuentas de servicio, grupos, usuarios) a los que se les asignará el rol de administrador."
  type        = list(string)
  default     = []
}

variable "sm_iam_role" {
  description = "Rol de IAM específico que se asignará al recurso de Secret Manager."
  type        = string
  default     = "roles/secretmanager.secretAccessor"
}

variable "sm_replication_location" {
  description = "Ubicación para la replicación de los datos del secreto."
  type        = string
  default     = null
}

