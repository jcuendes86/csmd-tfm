# ==================================================================================
# VARIABLES PARA EL MÓDULO NETWORK
# ==================================================================================

# ---------------------------------
# Variables Requeridas
# ---------------------------------

variable "project_id" {
  description = "ID del proyecto de Google Cloud donde se creará la red."
  type        = string
}

variable "region" {
  description = "Región donde se desplegarán los recursos de red."
  type        = string
}

variable "vpc_name" {
  description = "Nombre de la red VPC."
  type        = string
}

# ---------------------------------
# Variables Opcionales
# ---------------------------------

variable "vpc_description" {
  description = "Descripción opcional para la red VPC."
  type        = string
  default     = "VPC principal personalizada"
}

variable "vpc_auto_create_subnetworks" {
  description = "Si es true, la red se crea en modo automático, creando una subred por región. Si es false, se crea en modo personalizado."
  type        = bool
  default     = true
}

variable "vpc_routing_mode" {
  description = "Modo de enrutamiento de la red (REGIONAL o GLOBAL)."
  type        = string
  default     = "REGIONAL"
}

variable "vpc_delete_default_routes_on_create" {
  description = "Si es true, las rutas por defecto (0.0.0.0/0) se eliminarán tras la creación de la red."
  type        = bool
  default     = false
}

variable "vpc_network_firewall_policy_enforcement_order" {
  description = "Orden de aplicación de las políticas de firewall."
  type        = string
  default     = "AFTER_CLASSIC_FIREWALL"
}