output "alb_dns_name" {
  value = module.alb.dns_name
}

output "frontend_ecr" {
  value = module.frontend_ecr.repository_url
}

output "backend_ecr" {
  value = module.backend_ecr.repository_url
}

output "ecs_cluster_name" {
  value = module.ecs_cluster.cluster_name
}

output "ecs_frontend_service_name" {
  value = module.frontend_ecs_service.name
}

output "ecs_backend_service_name" {
  value = module.backend_ecs_service.name
}

output "ecs_frontend_task_definition_family" {
  value = module.frontend_ecs_service.task_definition_family
}

output "ecs_backend_task_definition_family" {
  value = module.backend_ecs_service.task_definition_family
}