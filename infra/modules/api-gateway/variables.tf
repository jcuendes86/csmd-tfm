###################
#### REQUIRED #####
###################

variable "project_id" {
 description = "The ID of the project in which the resource belongs."
 type        = string
}

variable "api_id" {
  description = "API Gateway API ID. Must be unique within a project and region, within a Cloud API Gateway instance. Is required when creating resources. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated"
  type        = string
}

variable "region" {
  description = "The location of the cloud run instance. eg us-central1"
  type        = string
}

variable "openapi_file_path" {
  description = "The path to the OpenAPI specification file."
  type        = string
}

variable "cloud_run_url" {
  description = "The URL of the Cloud Run service to be used in the OpenAPI spec."
  type        = string
}

variable "api_config_sa_email" {
  description = "The email of the service account that the API Gateway will use to sign the ID token when calling the Cloud Run service."
  type        = string
}
