# Variables allow us to customize our container name
variable "container_name" {
  description = "Value of the name for the Docker container"
  type        = string
  default     = "ExampleContainer"
}