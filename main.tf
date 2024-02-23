module "three-tier-app-infra" {
  source                        = "./three-tier-app-infra"
  project_name                  = "blogging-platform"
  environment                   = "staging"
  backend_service_cpu           = 512
  backend_service_memory        = 1024
  backend_service_port          = 3000
  region                        = "eu-central-1"
  frontend_service_cpu          = 512
  frontend_service_memory       = 1024
  frontend_service_port         = 80
  acm_certificate_arn           = "arn:aws:acm:eu-central-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
  terraform_remote_state_bucket = "terraform-remote-state-bucket"
}