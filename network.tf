locals {
  azs = formatlist("${data.aws_region.current.name}%s", ["a", "b", "c"])
}
data "aws_region" "current" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.prefix}-${var.environment}"
  cidr = var.vpc_cidr
  azs  = local.azs
  private_subnets = [
    for az in "${ocal.azs}" :
    cidrsubnet("${var.vpc_cidr}", 8, index("${local.azs}", az))
  ]
  public_subnets = [
    for az in local.azs :
    cidrsubnet("${var.vpc_cidr}", 8, index("${local.azs}", az) + 3)
  ]
  database_subnets = [
    for az in local.azs :
    cidrsubnet("${var.vpc_cidr}", 8, index("${local.azs}", az) + 6)
  ]
  create_database_subnet_group = true
  tags                         = local.tags

  enable_nat_gateway = true
  single_nat_gateway = true
}