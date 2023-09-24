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

# Configure our docker provider (specified in required_providers above)
provider "docker" {
  # Try without host variable first -- if you get an error like:  Cannot connect to the Docker daemon at unix:///var/run/docker.sock,
  # uncomment the line below and include the path to your PERSONAL docker.sock (i.e. change the Users/charliedobson)
  # host = "unix:///Users/charliedobson/.docker/run/docker.sock"
}

# Resource blocks define infrastructure components, can be physical or virtual (in this case a docker image)
# Requires two strings before the block: resource type ("docker_image"), and resource name ("fastapi_image")
# Used to create ID for docker image: docker_image.fastapi_image
resource "docker_image" "fastapi_image" {
  # Set the name of your docker image using the variables.tf file
  # Hint: replace [variable_name] with the name you define in variables.tf
  # name = vars.[variable_name]
  build {
    # Use the context and dockerfile arguments in conjunction to point to the Dockerfile in the current folder
    # Context tells docker at what directory to start looking (the current one)
    # Dockerfile tells docker the name of the dockerfile we want to build with
    # context =
    # dockerfile =
  }
}


# Define a resource block for "docker_container" following the example of "docker_image" above
# Hint: the resource block as is will not work! What are we missing?
resource "docker_container" {

  # Point the docker_container at the image we defined above
  # Hint: use the image_id property to reference the exact image
  # image =

  # Set the name of your container using the variables.tf file
  # name =

  # Docker configuration variables to tell docker what ports to run the container on.
  # For simplicity sake, we recommend setting them to the same value (the default fastAPI port is 8000)
  ports {
    # internal =
    # external =
  }
}
