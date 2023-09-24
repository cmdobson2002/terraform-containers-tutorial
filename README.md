# Terraform + Docker Tutorial

This repository contains a tutorial for members of CSCI 435 to walk through and understand how
Terraform can be used to quickly build, run, and destroy docker containers.

### Repository Structure
___
People walking through the tutorial should be working in the `tutorial` folder. The `final` 
folder contains the completed code that should be used if you get stuck. Their directory contents
are identical, the `tutorial` folder just has incomplete files! 

You don't really  need to worry about the `tutorial/app` directory -- it contains a single file which is used to create the FastAPI server when you actually run your docker container.

The four files you should be modifying are: 
1. `tutorial/Dockerfile`
2. `tutorial/main.tf`
3. `tutorial/variables.tf`
4. `tutoral/outputs.tf`

### Prerequisites
___
This project requires Docker and Terraform.
1. To download Docker, refer to [these docs](https://docs.docker.com/get-docker/) to choose the correct version for your system. Confirm the installation worked correctly and docker is running by running `docker --help` 
2. Refer to [these docs](https://developer.hashicorp.com/terraform/downloads) for installing terraform. Confirm the installation worked correctly by running `terraform -help`


### To Complete Tutorial
___
1. The first step to complete the tutorial is to complete the `Dockerfile`
   1. To test that you completed `Dockerfile` correctly, ensure you are in the `tutorial` directory and run `docker build -t myimage .` This should build a Docker image called `myimage`, which you can confirm by running `docker image ls`. Remove this image by running `docker image prune`.
2. Next, move to `main.tf`. Complete the two `resource` blocks for `docker_image` and `docker_container`. 
   1. You will need to simultaneously modify `variables.tf` to declare any values that are prepended with `vars.` or else terraform will get mad at you because the value doesn't exist.
3. Finally, move to `outputs.tf`. Following the comments, create an `output` that catches the `container_name` that you specified in `variables.tf`

### To run your code
___
1. When your code is error-free and you think it's ready to run, ensure you are in `tutorial` and run `terraform init`
   1. This will create a folder `.terraform.lock.hcl` that holds information on your `required_providers`
2. Run `terraform plan`. This will output a lot of information to your terminal, basically outlining all the changes terraform is going to make.
   1. NOTE: If this step fails with a warning that it can't connect to docker, go back to `main.tf` and specify the path to your `docker.sock` in the `provider "docker"` section.
3. Run `terraform apply` and enter `yes` when prompted so terraform will try to create your resources. 
   1. If this is successful, you should get an output block displaying the values you specified in `outputs.tf`
   2. If you want to specify values for the variables you define in `variables.tf`, you'll need to do so on the command line. That entire command will look like 
      ```
      terraform apply -var="container_name=[some_name]" -var="image_name=[some_name]"
      ```
4. You can confirm that your code worked in a couple ways
   1. On the command line, run `docker ps -a`. This will list all running containers. You should see your container running.
   2. In your web browser, navigate to `localhost:[PORT]` where you replace `[PORT]` with the port number you specified in `main.tf`. You should see the output `{"Hello":"World"}`
5. Tear everything down by running `terraform destroy` and entering `yes` when prompted.

### What to submit
___
To demonstrate that you successfully completed the tutorial, submit a few screenshots to Alejandro.
1. In your web browser, navigate to `localhost:[PORT]/docs`, again replacing `[PORT]` with your specified port number. Take a screenshot of the API docs that appear.
   1. Hint: If you didn't modify `app/main.py`, you should have two endpoints: `Read Root` and `Read Item`.
2. From the command line, take a screenshot of the `terraform apply` command you ran, including any variables you passed in.
3. Also screenshot the `Outputs` section that is printed at the end of the `apply` output.
   1. Hint: this should look something like:
   ```
      Outputs:

      container_id = [some_value]
      [another_key] = [another_value]
   ```


### Resources to create this tutorial
___
This tutorial leverages the [FastAPI docs](https://fastapi.tiangolo.com/deployment/docker/) for creating a FastAPI Docker container, and the Terraform docs for [building docker containers](https://developer.hashicorp.com/terraform/tutorials/docker-get-started) and [building docker images](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image).
