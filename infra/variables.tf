#####################################
##         Global Variables        ##
#####################################
variable "project_id" {
  description = "The ID of the Google Cloud project to use."
  type        = string
  default     = "csmd-tfm-jcuendes"
}

variable "region" {
  description = "The region to deploy resources in."
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "The zone to deploy resources in."
  type        = string
  default     = "europe-west1-b"
}

variable "enable_cb_creation" {
  description = "Flag to enable or disable the creation of Cloud Build triggers."
  type        = bool
  default     = false
}

variable "enable_model_creation" {
  description = "Flag to enable or disable the creation of the BigQuery ML model."
  type        = bool
  default     = false
}