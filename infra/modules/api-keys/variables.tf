###################
#### REQUIRED #####
###################

variable "project_id" {
 description = "The ID of the project in which the resource belongs."
 type        = string
}

variable "apikeys_name" {
 description = "The name of the API key."
 type        = string
}

variable "apikeys_display_name" {
 description = "The display name of the API key."
 type        = string
}

variable "managed_service" {
 description = "The name of the service associated with the API key."
 type        = string
}
