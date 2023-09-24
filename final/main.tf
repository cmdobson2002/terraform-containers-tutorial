
# Contains terraform-specific settings, such as required providers to provision infrastructure
# Each provider takes a source, which is the hostname/provider type in the Terraform Registry
# So our docker provider is fully: registry.terraform.io/kreuzwerker/docker
# Version constraint is optional, terraform automatically downloads most recent version
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

# Configures specified provider (docker)
# You can use multiple provider blocks to manage resources from different providers (AWS, Azure, etc.)
provider "docker" {
  # Try without this variable first -- if it can't connect to docker, include the path to your PERSONAL docker.sock (i.e. change the Users/charliedobson)
  host = "unix:///Users/charliedobson/.docker/run/docker.sock"
}

# Resource blocks define infrastructure components, can be physical or virtual (docker image)
# Requires two strings before the block: resource type ("docker_image"), and resource name ("fastapi_image")
# Used to create ID for docker image: docker_container.fastapi
resource "docker_image" "fastapi_image" {
  name = var.image_name
  build {
    context = "."
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "fastapi" {
  image = docker_image.fastapi_image.image_id
  name  = var.container_name

  # Docker configuration values
  ports {
    internal = 8000
    external = 8000
  }
}
