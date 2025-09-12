# ==================================================================================
# RECURSO: CUENTA DE SERVICIO
# Crea una cuenta de servicio en Google Cloud.
# ==================================================================================
resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = var.sa_account_id
  display_name = var.sa_display_name
  description  = var.sa_description
  disabled     = var.sa_disabled
}

# ==================================================================================
# RECURSO: ASIGNACIÓN DE ROLES IAM
# Asigna los roles de IAM especificados a la cuenta de servicio creada.
# ==================================================================================
resource "google_project_iam_member" "roles" {
  project  = var.project_id
  # Itera sobre la lista de roles para asignar cada uno.
  for_each = toset(var.sa_roles)
  role     = each.value
  member   = "serviceAccount:${google_service_account.service_account.email}"
}