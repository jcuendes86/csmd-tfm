# ==================================================================================
# RECURSO: SERVICIO DE CLOUD RUN
# Crea y configura un servicio en Cloud Run.
# ==================================================================================
resource "google_cloud_run_service" "service" {
  project  = var.project_id
  name     = var.service_name
  location = var.region

  # Metadatos del servicio, incluyendo configuración de ingreso (ingress).
  metadata {
    annotations = {
      "run.googleapis.com/client-name" = "terraform"
      "run.googleapis.com/ingress"     = var.cr_vpc_ingress
    }
  }

  # Plantilla para las revisiones del servicio.
  template {
    metadata {
      annotations = {
        # Configuración de autoescalado.
        "autoscaling.knative.dev/minScale" = var.cr_min_instances
        "autoscaling.knative.dev/maxScale" = var.cr_max_instances
      }
    }
    spec {
      # Cuenta de servicio que utilizará la revisión.
      service_account_name = var.cr_service_account

      # Montaje de secretos como volúmenes.
      volumes {
        name = var.volume_name
        secret {
          secret_name = var.secret_name
          items {
            key  = "latest"
            path = ".env"
          }
        }
      }

      # Configuración del contenedor.
      containers {
        # Imagen de ejemplo. Esta será actualizada por el pipeline de Cloud Build.
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        
        # Límites de recursos para el contenedor.
        resources {
          limits = {
            cpu    = var.cr_container_limit_cpu
            memory = var.cr_container_limit_memory
          }
        }

        # Montaje del volumen de secretos en el contenedor.
        volume_mounts {
          name       = var.volume_name
          mount_path = var.volume_mount_path
        }
      }
    }
  }

  # Genera automáticamente un nombre para cada nueva revisión.
  autogenerate_revision_name = true

  # ==================================================================================
  # CICLO DE VIDA
  # Ignora los cambios en ciertos metadatos y en la imagen del contenedor.
  # Esto es crucial para permitir que los pipelines de CI/CD actualicen la imagen
  # sin que Terraform intente revertir el cambio.
  # ==================================================================================
  lifecycle {
    ignore_changes = [
      template[0].metadata[0].annotations["client.knative.dev/user-image"],
      template[0].metadata[0].annotations["run.googleapis.com/client-name"],
      template[0].metadata[0].annotations["run.googleapis.com/client-version"],
      metadata[0].annotations["client.knative.dev/user-image"],
      metadata[0].annotations["run.googleapis.com/client-name"],
      metadata[0].annotations["run.googleapis.com/client-version"],
      metadata[0].annotations["run.googleapis.com/operation-id"],
      template[0].spec[0].containers[0].image,
      template[0].metadata[0].labels["run.googleapis.com/startupProbeType"],
      template[0].metadata[0].labels["client.knative.dev/nonce"]
    ]
  }
}
