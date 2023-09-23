
# Contains terraform-specific settings, such as required providers to provision infrastructure
# Each provider takes a source, which is the hostname/provider type in the Terraform Registry
# So our docker provider is fully: registry.terraform.io/kreuzwerker/docker
# Version constraint is optional, terraform automatically downloads most recent version
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
  }
}

resource "google_cloud_run_v2_service" "default" {
  project = "vm-container-demo"
  name     = "cloudrun-service"
  location = "us-central1"
  ingress = "INGRESS_TRAFFIC_ALL"


  template {
    containers {
      image = "us-central1-docker.pkg.dev/vm-container-demo/vm-container-demo/demo-fastapi-image"
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_v2_service.default.location
  project     = google_cloud_run_v2_service.default.project
  service     = google_cloud_run_v2_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}


