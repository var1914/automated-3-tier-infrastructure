provider "aws" {
  region = var.region # Replace with your desired AWS region 
}

terraform {
  backend "s3" {
    bucket = "terraform-state-varun-blogs" # Replace with your bucket name
    key    = "terraform-state.tfstate"     # its upto you
    region = "eu-central-1"                # Replace with your region name
  }
}