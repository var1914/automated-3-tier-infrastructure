# automated-3-tier-infrastructure
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.ecs_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.ecs_frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.db_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.db_access_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.db_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_service_discovery_http_namespace.ecs_service_namespace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_http_namespace) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

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
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | The engine for the database | `string` | `"mysql"` | no |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | The version for the database engine | `string` | `"8.0"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | The instance class for the database | `string` | `"db.t3.micro"` | no |
| <a name="input_db_parameter_group_family"></a> [db\_parameter\_group\_family](#input\_db\_parameter\_group\_family) | The family for the database parameter group | `string` | `"mysql8.0"` | no |
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
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | n/a |
| <a name="output_backend_ecr"></a> [backend\_ecr](#output\_backend\_ecr) | n/a |
| <a name="output_ecs_backend_service_name"></a> [ecs\_backend\_service\_name](#output\_ecs\_backend\_service\_name) | n/a |
| <a name="output_ecs_backend_task_definition_family"></a> [ecs\_backend\_task\_definition\_family](#output\_ecs\_backend\_task\_definition\_family) | n/a |
| <a name="output_ecs_cluster_name"></a> [ecs\_cluster\_name](#output\_ecs\_cluster\_name) | n/a |
| <a name="output_ecs_frontend_service_name"></a> [ecs\_frontend\_service\_name](#output\_ecs\_frontend\_service\_name) | n/a |
| <a name="output_ecs_frontend_task_definition_family"></a> [ecs\_frontend\_task\_definition\_family](#output\_ecs\_frontend\_task\_definition\_family) | n/a |
| <a name="output_frontend_ecr"></a> [frontend\_ecr](#output\_frontend\_ecr) | n/a |  
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
