###################
#### REQUIRED #####
###################

variable "project_id" {
  description = ") The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
}

variable "region" {
  description = "The region to deploy resources in. This is used for regional resources."
  type = string
}

variable "cb_trigger_name" {
  description = "The name of the Cloud Build trigger."
  type        = string
}

variable "cb_trigger_filename" {
  description = "Path, from the source root, to a file whose contents is used for the template."
  type        = string
}

variable "cb_repo_uri" {
  description = "The uri of the repository"
  type        = string
}

variable "cb_repo_ref" {
  description = "The ref of the repository"
  type        = string
}

variable "cb_service_account_email" {
  description = "The service account email"
  type        = string
}


###################
#### OPTIONAL #####
###################

variable "cb_trigger_description" {
  description = "The description of the Cloud Build trigger."
  type        = string
  default     = "Ejecuta el pipeline de Dataflow mediante una plantilla Flex"
}

variable "cb_repo_type" {
  description = "The type of repository."
  type        = string
  default     = "GITHUB"
  }

variable "cb_trigger_substitutions" {
  description = "Substitutions data for Build resource."
  type        = map(string)
  default     = {}
}

