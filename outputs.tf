# Outputs catch values that are generated during the Terraform apply stage and output them to the terminal
output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.fastapi.id
}