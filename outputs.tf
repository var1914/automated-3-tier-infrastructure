output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.three-tier-app-infra.alb_dns_name
}