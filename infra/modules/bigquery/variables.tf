# ==================================================================================
# VARIABLES PARA EL MÓDULO BIGQUERY
# ==================================================================================

# ---------------------------------
# Variables Requeridas
# ---------------------------------

variable "project_id" {
  description = "ID del proyecto de Google Cloud donde se crearán los recursos de BigQuery."
  type        = string
}

variable "bq_dataset_id" {
  description = "ID único para el dataset de BigQuery que se va a crear."
  type        = string
}

variable "bq_table_id" {
  description = "ID único para la tabla de BigQuery que se va a crear."
  type        = string
}

# ---------------------------------
# Variables Opcionales (Dataset)
# ---------------------------------

variable "bq_dataset_location" {
  description = "Ubicación del dataset de BigQuery."
  type        = string
  default     = "EU"
}

variable "bq_dataset_description" {
  description = "Descripción para el dataset de BigQuery."
  type        = string
  default     = "BigQuery dataset creado por Terraform"
}

variable "bq_dataset_labels" {
  description = "Etiquetas para el dataset de BigQuery."
  type        = map(string)
  default     = null
}

variable "bq_dataset_delete_contents_on_destroy" {
  description = "Si se establece en true, se eliminará el contenido del dataset al destruir el recurso."
  type        = bool
  default     = true
}

# ---------------------------------
# Variables Opcionales (Tabla)
# ---------------------------------

variable "bq_table_expiration_time" {
  description = "Tiempo en milisegundos desde la época en que la tabla expira. Si no se especifica, la tabla persistirá indefinidamente."
  default     = null
}

variable "bq_table_friendly_name" {
  description = "Nombre descriptivo para la tabla."
  default     = ""
}

variable "bq_table_clustering" {
  description = "Lista de nombres de columnas para usar en el clustering de datos."
  type        = list(any)
  default     = null
}

variable "bq_table_deletion_protection" {
  description = "Protección contra la eliminación de la tabla. Si es true, Terraform no podrá destruir la instancia."
  type        = bool
  default     = true
}