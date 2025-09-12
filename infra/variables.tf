# ==================================================================================
# VARIABLES GLOBALES
# Definición de las variables utilizadas en la configuración de Terraform.
# ==================================================================================

# ---------------------------------
# Configuración del Proyecto
# ---------------------------------

variable "project_id" {
  description = "ID del proyecto de Google Cloud donde se desplegarán los recursos."
  type        = string
  default     = "csmd-tfm-jcuendes"
}

variable "region" {
  description = "Región donde se desplegarán los recursos de Google Cloud."
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "Zona específica dentro de la región para el despliegue de recursos."
  type        = string
  default     = "europe-west1-b"
}

# ---------------------------------
# Habilitación de Recursos
# ---------------------------------

variable "enable_cb_creation" {
  description = "Flag para habilitar o deshabilitar la creación de los triggers de Cloud Build."
  type        = bool
  default     = false
}

variable "enable_model_creation" {
  description = "Flag para habilitar o deshabilitar la creación del modelo de BigQuery ML."
  type        = bool
  default     = false
}