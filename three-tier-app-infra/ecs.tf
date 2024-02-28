module "s3_env_bucket" {
  count  = var.create_env_bucket ? 1 : 0
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "${local.prefix}-envs"
}
resource "aws_service_discovery_http_namespace" "ecs_service_namespace" {
  name = local.prefix
  tags = local.tags
}

module "s3_frontend_asset_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "${local.prefix}-frontend-assets"
}

module "ecs_cluster" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name                = "${local.prefix}-ecs-cluster"
  create_cloudwatch_log_group = true
  tags                        = local.tags
}

module "backend_ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name                 = "${local.prefix}-backend"
  repository_image_tag_mutability = "MUTABLE"
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = local.tags

}

module "frontend_ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name                 = "${local.prefix}-frontend"
  repository_image_tag_mutability = "MUTABLE"
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = local.tags
}

module "backend_ecs_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  name                   = "${local.prefix}-backend"
  cluster_arn            = module.ecs_cluster.cluster_arn
  enable_execute_command = true
  cpu                    = var.backend_service_cpu
  memory                 = var.backend_service_memory

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  container_definitions = {
    backend = {
      cpu                      = "${var.backend_service_cpu}"
      memory                   = "${var.backend_service_memory}"
      image                    = module.backend_ecr.repository_url
      environment              = "${var.backend_service_environment}"
      readonly_root_filesystem = "${var.backend_readonly_root_filesystem}"
      port_mappings = [
        {
          containerPort = "${var.backend_service_port}"
          protocol      = "tcp"
          name          = "${local.prefix}-backend"
        }
      ]
      enable_cloudwatch_logging = true
      log_configuration = {
        log_driver = "awslogs"
        options = {
          awslogs-group         = "/aws/ecs/${local.prefix}-backend"
          awslogs-region        = "${var.region}"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  }

  service_connect_configuration = {
    namespace = aws_service_discovery_http_namespace.ecs_service_namespace.http_name
    service = {
      client_alias = {
        port     = "${var.backend_service_port}"
        dns_name = "${local.prefix}-backend"
      }
      port_name      = "${local.prefix}-backend"
      discovery_name = "${local.prefix}-backend"
    }
  }

  subnet_ids = module.vpc.private_subnets
  security_group_rules = {
    ingress = {
      type                     = "ingress"
      from_port                = "${var.backend_service_port}"
      to_port                  = "${var.backend_service_port}"
      protocol                 = "tcp"
      source_security_group_id = module.frontend_ecs_service.security_group_id
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = local.tags
}

module "frontend_ecs_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  name                   = "${local.prefix}-frontend"
  cluster_arn            = module.ecs_cluster.cluster_arn
  enable_execute_command = true

  cpu    = var.frontend_service_cpu
  memory = var.frontend_service_memory

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  container_definitions = {
    frontend = {
      cpu         = "${var.frontend_service_cpu}"
      memory      = "${var.frontend_service_memory}"
      image       = module.frontend_ecr.repository_url
      environment = "${var.frontend_service_environment}"
      port_mappings = [
        {
          name          = "${local.prefix}-frontend"
          containerPort = "${var.frontend_service_port}"
          protocol      = "tcp"
        }
      ]
      readonly_root_filesystem  = false
      enable_cloudwatch_logging = true
      log_configuration = {
        log_driver = "awslogs"
        options = {
          awslogs-group         = "/aws/ecs/${local.prefix}-frontend"
          awslogs-region        = "${var.region}"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  }
  service_connect_configuration = {
    namespace = aws_service_discovery_http_namespace.ecs_service_namespace.http_name
    service = {
      client_alias = {
        port     = var.frontend_service_port
        dns_name = "${local.prefix}-frontend"
      }
      port_name      = "${local.prefix}-frontend"
      discovery_name = "${local.prefix}-frontend"
    }
  }

  load_balancer = {
    service = {
      target_group_arn = aws_lb_target_group.this.arn
      container_name   = "frontend"
      container_port   = "${var.frontend_service_port}"
    }
  }

  subnet_ids = module.vpc.private_subnets
  security_group_rules = {
    http_ingress = {
      description              = "Allow HTTP ingress"
      type                     = "ingress"
      from_port                = "${var.frontend_service_port}"
      to_port                  = "${var.frontend_service_port}"
      protocol                 = "tcp"
      source_security_group_id = module.alb.security_group_id
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_cloudwatch_log_group" "ecs_frontend" {
  name              = "/aws/ecs/${local.prefix}-frontend"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "ecs_backend" {
  name              = "/aws/ecs/${local.prefix}-backend"
  retention_in_days = 30
}