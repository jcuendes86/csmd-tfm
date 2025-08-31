resource "google_cloud_run_service" "service" {
  name     = var.service_name
  location = var.region

  metadata {
    annotations = {
      "run.googleapis.com/client-name" = "terraform"
      "run.googleapis.com/ingress"     = var.cr_vpc_ingress
    }
  }

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale"        = var.cr_min_instances
        "autoscaling.knative.dev/maxScale"        = var.cr_max_instances
      }
    }
    spec {
        service_account_name = var.cr_service_account

        volumes {
            name = var.volume_name
            secret {
                secret_name = var.secret_name
                items {
                    key = "latest"
                    path    = ".env"
                }
            }
        }

      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        resources {
          limits = {
            cpu    = var.cr_container_limit_cpu
            memory = var.cr_container_limit_memory
          }
        }

        volume_mounts {
          name = var.volume_name
          mount_path = var.volume_mount_path
        }
      }
    }
  }

  autogenerate_revision_name = true

  lifecycle {
    ignore_changes = [
      template.0.metadata.0.annotations["client.knative.dev/user-image"],
      template.0.metadata.0.annotations["run.googleapis.com/client-name"],
      template.0.metadata.0.annotations["run.googleapis.com/client-version"],
      metadata.0.annotations["client.knative.dev/user-image"],
      metadata.0.annotations["run.googleapis.com/client-name"],
      metadata.0.annotations["run.googleapis.com/client-version"],
      metadata.0.annotations["run.googleapis.com/operation-id"],
      template.0.spec.0.containers.0.image,
      template.0.metadata.0.labels["run.googleapis.com/startupProbeType"], #"run.googleapis.com/startupProbeType" = "Default"
      template.0.metadata.0.labels["client.knative.dev/nonce"]
    ]
  }

}
