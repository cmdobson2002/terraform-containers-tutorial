# Outputs catch values that are generated during the Terraform apply stage and output them to the terminal
output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.fastapi.id
}

# Write another output to catch the name of the docker container, which you specified in variables.tf
# Hint: you can see all the possible values you can catch when you run "terraform plan"