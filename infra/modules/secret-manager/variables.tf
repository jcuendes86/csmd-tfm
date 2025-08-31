###################
#### REQUIRED #####
###################

variable "project_id" {
 description = "The ID of the project in which the resource belongs."
 type        = string
}

variable "secret_id" {
 description = "Secret ID. This must be unique within the project."
 type        = string
}

###################
#### OPTIONAL #####
###################

variable "sm_version_data_template" {
 description = "Template de secretos a añadir. Opcional"
 default     = null
}

variable "sm_members_admins" {
 description = "List of members (SA, Groups, Users) to atach admin role"
 type        = list(string)
 default     = []
}

variable "sm_iam_role" {
 description = "Specific role to binding to Secret Manager resource. Default value is roles/secretmanager.secretAccessor."
 type        = string
 default     = "roles/secretmanager.secretAccessor"
}

variable "sm_replication_location" {
 description = "The canonical IDs of the location to replicate data. For example: europe-west1."
 type        = string
 default     = null
}

