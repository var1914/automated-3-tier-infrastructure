module "three-tier-app-infra" {
  source                  = "./three-tier-app-infra"
  project_name            = var.project_name
  environment             = var.environment
  backend_service_cpu     = var.backend_service_cpu
  backend_service_memory  = var.backend_service_memory
  backend_service_port    = var.backend_service_port
  region                  = var.region
  frontend_service_cpu    = var.frontend_service_cpu
  frontend_service_memory = var.frontend_service_memory
  frontend_service_port   = var.frontend_service_port
  acm_certificate_arn     = var.acm_certificate_arn
}