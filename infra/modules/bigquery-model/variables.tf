###################
#### REQUIRED #####
###################

variable "project_id" {
  description = "The ID of the Google Cloud project to use."
  type = string
}

variable "region" {
  description = "The name region in which resources will be created."
  type        = string
}


variable "bq_job_id" {
    description = "The BigQuery job id."
    type        = string
}

variable "bq_job_query" {
  description = "The query to be executed in the BigQuery job."
  type        = string
}

###################
#### OPTIONAL #####
###################

variable "bq_job_query_cache" {
  description = "Value to enable or disable query cache"
  type    = bool
  default = false
}

variable "bq_job_create_disposition" {
  description = "Value to specify the create disposition for the job"
  type    = string
  default = ""
}

variable "bq_job_write_disposition" {
  description = "Value to specify the write disposition for the job"
  type    = string
  default = ""
}

variable "bq_job_lifecycle_ignore_changes_active" {
  description = "Whether to ignore changes to job_id in the lifecycle block"
  type    = bool
  default = "false"
}