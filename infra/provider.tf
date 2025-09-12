# ==================================================================================
# CONFIGURACIÓN DEL PROVEEDOR DE GOOGLE CLOUD
# Define el proveedor de Terraform para Google Cloud, especificando el proyecto,
# la región y la zona que se utilizarán para desplegar los recursos.
# ==================================================================================
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}