locals {
  prefix = "${var.project_name}-${var.environment}"
  tags = {
    Terraform   = "true"
    Environment = "${var.environment}"
    Name        = "${local.prefix}"
  }
}