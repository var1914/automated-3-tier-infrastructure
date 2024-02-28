output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.three-tier-app-infra.alb_dns_name
}

output "frontend_ecr" {
  description = "The ECR URL for the frontend"
  value       = module.three-tier-app-infra.frontend_ecr
}

output "backend_ecr" {
  description = "The ECR URL for the backend"
  value       = module.three-tier-app-infra.backend_ecr
}