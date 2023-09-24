# Variables allow us to customize our container name by passing in values on the command line
variable "container_name" {
  description = "Value of the name for the Docker container"
  type        = string
  default     = "ExampleContainer"
}

# Write a variable similar to the one above to customize our image name
# Hint: Docker image names must be lowercase!
