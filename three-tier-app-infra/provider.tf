provider "aws" {
  region = var.region # Replace with your desired AWS region
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

################################
# Terraform remote state
################################
terraform {
  backend "s3" {
    bucket = var.terraform_remote_state_bucket
    key    = var.terraform_remote_state_key
    region = var.region
  }
}