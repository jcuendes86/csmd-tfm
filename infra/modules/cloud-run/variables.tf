# ==================================================================================
# VARIABLES PARA EL MÓDULO CLOUD RUN
# ==================================================================================

# ---------------------------------
# Variables Requeridas
# ---------------------------------

variable "project_id" {
  description = "ID del proyecto de Google Cloud al que pertenece el recurso."
  type        = string
}

variable "service_name" {
  description = "Nombre del servicio de Cloud Run. Debe ser único en la región."
  type        = string
}

variable "region" {
  description = "Ubicación de la instancia de Cloud Run."
  type        = string
}

variable "cr_service_account" {
  description = "Email de la cuenta de servicio asociada al servicio de Cloud Run."
  type        = string
}

variable "volume_name" {
  description = "Nombre del volumen que se va a montar."
  type        = string
}

variable "secret_name" {
  description = "Nombre del secreto en Secret Manager que se montará como volumen."
  type        = string
}

variable "volume_mount_path" {
  description = "Ruta dentro del contenedor donde se montará el volumen."
  type        = string
}

# ---------------------------------
# Variables Opcionales
# ---------------------------------

variable "cr_max_instances" {
  description = "Número máximo de instancias para el servicio de Cloud Run."
  type        = string
  default     = "25"
}

variable "cr_min_instances" {
  description = "Número mínimo de instancias para el servicio de Cloud Run."
  type        = string
  default     = "0"
}

variable "cr_vpc_egress" {
  description = "Configuración de salida (egress) de VPC para el servicio."
  type        = string
  default     = "all-traffic"

  validation {
    condition     = contains(["all-traffic", "private-ranges-only"], var.cr_vpc_egress)
    error_message = "El valor de cr_vpc_egress debe ser 'all-traffic' o 'private-ranges-only'."
  }
}

variable "cr_vpc_ingress" {
  description = "Configuración de entrada (ingress) para el servicio."
  type        = string
  default     = "internal-and-cloud-load-balancing"

  validation {
    condition     = contains(["all", "internal", "internal-and-cloud-load-balancing"], var.cr_vpc_ingress)
    error_message = "El valor de cr_vpc_ingress debe ser 'all', 'internal' o 'internal-and-cloud-load-balancing'."
  }
}

variable "cr_container_limit_memory" {
  description = "Límite de memoria para el contenedor del servicio."
  type        = string
  default     = "512M"
}

variable "cr_container_limit_cpu" {
  description = "Límite de CPU para el contenedor del servicio."
  type        = number
  default     = 1
}
