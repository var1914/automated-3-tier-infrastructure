# Terraform Scripts for 3-Tier Application Architecture

This repository contains Terraform scripts to deploy a 3-tier application architecture on AWS. The architecture consists of ECS (Elastic Container Service) for frontend and backend containers, RDS (Relational Database Service) as the database, ECR (Elastic Container Registry) for Docker image repository, and ALB (Application Load Balancer) on top of the frontend.

## Prerequisites

Before you begin, make sure you have the following prerequisites installed:

- Terraform
- AWS CLI
- Docker (if you're building custom Docker images)

## Deployment Steps

Follow these steps to deploy the infrastructure using Terraform:

1. Clone this repository to your local machine:

    ```bash
    git clone git@github.com:var1914/automated-3-tier-infrastructure.git
    ```

2. Navigate to the repository directory:

    ```bash
    cd automated-3-tier-infrastructure
    ```

3. Initialize Terraform:

    ```bash
    terraform init
    ```

3. Go Through `variables.tf`, analyse what all variables you want to customise as per your needs

4. Review and modify file like `stage.vars/prod.vars`, review  add more variables in `main.tf`, if you are adding at `stage.vars/prod.vars` files to set your desired configurations. You may need to update variables such as region, AWS profile, etc on local machine.

5. If you are planning to create multiple environment, its good to create terraform workspaces, which will make sure of isolation of your multiple duplicated environment

    ```bash
    For e.g.:
    terraform workspace new stage 
    OR
    terraform workspace new prod
    ```

5. Plan the Terraform configuration to review the infrastructure:

    ```bash
    terraform workspace select stage/prod
    terraform plan --var-file stage.tfvars/prod.tfvars
    ```

6. Apply the Terraform configuration to create the infrastructure:

    ```bash
    terraform workspace select stage/prod
    terraform apply --var-file stage.tfvars/prod.tfvars
    ```

7. Confirm the deployment by reviewing the Terraform Apply and entering 'yes' when prompted.

8. Once the deployment is complete, You need to push docker image.

9. Build and push your custom Docker images to ECR:

    ```bash
    # Build the Docker images
    docker build -t your-image-name .

    FOR FRONTEND: 
    
    # Tag the Docker image for ECR
    docker tag your-image-name:latest <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/"${var.project_name}-${var.environment}-frontend":latest

    # Login to ECR
    aws ecr get-login-password --region <REGION> | docker login --username AWS --password- stdin <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/"${var.project_name}-${var.environment}-frontend"

    # Push to ECR
    docker push <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/"${var.project_name}-${var.environment}-frontend"

    FOR BACKEND: 

    # Tag the Docker image for ECR
    docker tag your-image-name:latest <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/"${var.project_name}-${var.environment}-backend":latest

    # Login to ECR
    aws ecr get-login-password --region <REGION> | docker login --username AWS --password- stdin <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/"${var.project_name}-${var.environment}-backend"

    # Push to ECR
    docker push <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/"${var.project_name}-${var.environment}-backend"
    

10. Access your application by mapping ALB DNS ( Which you will get from Terraform Output ) to your DNS.

## Cleanup

To tear down the infrastructure and delete all resources created by Terraform, run:

    ```bash
    terraform workspace select stage/prod
    terraform destroy
    ```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | The ARN for the ACM certificate | `string` | n/a | yes |
| <a name="input_alb_public_access"></a> [alb\_public\_access](#input\_alb\_public\_access) | Whether the ALB should be publicly accessible | `bool` | `true` | no |
| <a name="input_backend_readonly_root_filesystem"></a> [backend\_readonly\_root\_filesystem](#input\_backend\_readonly\_root\_filesystem) | Whether the backend service should have a read-only root filesystem | `bool` | `true` | no |
| <a name="input_backend_service_cpu"></a> [backend\_service\_cpu](#input\_backend\_service\_cpu) | The CPU units for the backend service | `number` | `256` | no |
| <a name="input_backend_service_environment"></a> [backend\_service\_environment](#input\_backend\_service\_environment) | Environment variables for the backend service | `list(map(string))` | `null` | no |
| <a name="input_backend_service_memory"></a> [backend\_service\_memory](#input\_backend\_service\_memory) | The memory for the backend service | `number` | `512` | no |
| <a name="input_backend_service_port"></a> [backend\_service\_port](#input\_backend\_service\_port) | The port for the backend service | `number` | `3000` | no |
| <a name="input_create_env_bucket"></a> [create\_env\_bucket](#input\_create\_env\_bucket) | Whether to create an environment bucket | `bool` | `false` | no |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | The engine for the database | `string` | `"postgres"` | no |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | The version for the database engine | `string` | `"11.5"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | The instance class for the database | `string` | `"db.t2.micro"` | no |
| <a name="input_db_parameter_group_family"></a> [db\_parameter\_group\_family](#input\_db\_parameter\_group\_family) | The family for the database parameter group | `string` | `"postgres11"` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | The port for the database | `number` | `5432` | no |
| <a name="input_db_publicly_accessible"></a> [db\_publicly\_accessible](#input\_db\_publicly\_accessible) | Whether the database should be publicly accessible | `bool` | `false` | no |
| <a name="input_db_storage_size"></a> [db\_storage\_size](#input\_db\_storage\_size) | The storage size for the database | `number` | `20` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the infrastructure | `string` | `"stage"` | no |
| <a name="input_frontend_service_cpu"></a> [frontend\_service\_cpu](#input\_frontend\_service\_cpu) | The CPU units for the frontend service | `number` | `256` | no |
| <a name="input_frontend_service_environment"></a> [frontend\_service\_environment](#input\_frontend\_service\_environment) | Environment variables for the frontend service | `list(map(string))` | `null` | no |
| <a name="input_frontend_service_memory"></a> [frontend\_service\_memory](#input\_frontend\_service\_memory) | The memory for the frontend service | `number` | `512` | no |
| <a name="input_frontend_service_port"></a> [frontend\_service\_port](#input\_frontend\_service\_port) | The port for the frontend service | `number` | `80` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region for the infrastructure | `string` | `"us-west-2"` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Whether to skip the final snapshot | `bool` | `true` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | The DNS name of the ALB |  
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
