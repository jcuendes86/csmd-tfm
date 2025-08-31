###################
#### REQUIRED #####
###################

variable "service_name" {
  description = "Cloud Run service name. Must be unique within a namespace, within a Cloud Run region. Is required when creating resources. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated"
  type        = string
}
variable "region" {
  description = "The location of the cloud run instance. eg us-central1"
  type        = string
}

variable "cr_service_account" {
  description = "The email of the service account associated with the Cloud Run service. If not provided, the default Compute Engine service account will be used."
  type        = string
}

variable "volume_name" {
  description = "The name of the volume to mount. Must be a valid DNS_LABEL and unique within the container."
  type        = string
}

variable "secret_name" {
  description = "The name of the secret in Secret Manager to mount as a volume."
  type        = string
}

variable "volume_mount_path" {
  description = "The path within the container at which the volume should be mounted. Must not contain ':'"
  type        = string
}


###################
#### OPTIONAL #####
###################

variable "cr_max_instances" {
  description = "Cloud Run max instances. Default 25"
  type        = string
  default     = "25"
}

variable "cr_min_instances" {
  description = "Cloud Run min instances. Default 0"
  type        = string
  default     = "0"
}

variable "cr_vpc_egress" {
  description = "The egress settings for the Cloud Run service. Possible values are 'all-traffic', 'private-ranges-only'"
  type        = string
  default     = "all-traffic"
  
  validation {
    condition     = contains(["all-traffic", "private-ranges-only"], var.cr_vpc_egress)
    error_message = "The cr_vpc_egress value must be one of: all-traffic, private-ranges-only."
  }
}

variable "cr_vpc_ingress" {
  description = "The ingress settings for the Cloud Run service. Possible values are 'all', 'internal', 'internal-and-cloud-load-balancing'"
  type        = string
  default     = "internal-and-cloud-load-balancing"
  
  validation {
    condition     = contains(["all", "internal", "internal-and-cloud-load-balancing"], var.cr_vpc_ingress)
    error_message = "The cr_vpc_ingress value must be one of: all, internal, internal-and-cloud-load-balancing."
  }
}

variable "cr_container_limit_memory" {
  description = "Cloud run service container limit memory. Default 512M"
  type        = string
  default     = "512M"
}

variable "cr_container_limit_cpu" {
  description = "Cloud run service container limit cpu. Default 1"
  type        = number
  default     = 1
}
