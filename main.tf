
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

resource "docker_image" "fastapi_image" {
  name = "fastapi_image"
  build {
    context = "."
    dockerfile = "Dockerfile"
  }
}

# Resource blocks define infrastructure components, can be physical or virtual (docker container)
# Requires two strings before the block: resource type ("docker_image"), and resource name ("nginx")
# Used to create ID for docker image: docker_container.fastapi
# Can take arguments such as machine sizes, disk image names
resource "docker_container" "fastapi" {
  image = docker_image.fastapi_image.image_id
  name  = "fastapi_container"

  # Docker configuration values
  ports {
    internal = 8000
    external = 8000
  }
}
