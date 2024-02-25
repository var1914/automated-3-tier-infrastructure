module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${local.prefix}-${var.db_engine}-db"

  engine               = var.db_engine
  major_engine_version = var.db_engine_version
  instance_class       = var.db_instance_class
  allocated_storage    = var.db_storage_size
  storage_encrypted    = false
  skip_final_snapshot  = var.skip_final_snapshot
  username             = "master"

  manage_master_user_password = true
  port                        = var.db_port

  publicly_accessible = var.db_publicly_accessible

  vpc_security_group_ids = [aws_security_group.db_sg.id]

  # disable backups to create DB faster
  backup_retention_period = 0

  tags = local.tags
  # DB subnet group
  db_subnet_group_name = module.vpc.database_subnet_group
  # DB parameter group
  family = var.db_parameter_group_family

  deletion_protection = false
}

resource "aws_security_group" "db_sg" {
  name        = "${local.prefix}-db-sg"
  description = "Security group for ${local.prefix} DB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Allow Backend Access"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [module.backend_ecs_service.security_group_id]
  }
}