# ==================================================================================
# VARIABLES PARA EL MÓDULO SERVICE ACCOUNT
# ==================================================================================

# ---------------------------------
# Variables Requeridas
# ---------------------------------

variable "project_id" {
  description = "ID del proyecto de Google Cloud al que pertenece el recurso."
  type        = string
}

variable "sa_account_id" {
  description = "ID de la cuenta que se utilizará para generar el email de la cuenta de servicio."
  type        = string
}

variable "sa_display_name" {
  description = "Nombre para mostrar de la cuenta de servicio."
  type        = string
}

# ---------------------------------
# Variables Opcionales
# ---------------------------------

variable "sa_description" {
  description = "Descripción de la cuenta de servicio."
  type        = string
  default     = null
}

variable "sa_disabled" {
  description = "Indica si la cuenta de servicio está deshabilitada o no."
  type        = bool
  default     = false
}

variable "sa_roles" {
  description = "Lista de roles de IAM que se aplicarán a la cuenta de servicio."
  type        = list(string)
  default     = []
}
