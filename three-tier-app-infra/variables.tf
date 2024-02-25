variable "environment" {
  description = "The environment for the infrastructure"
  type        = string
  default     = "stage"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "backend_service_cpu" {
  description = "The CPU units for the backend service"
  type        = number
  default     = 256
}

variable "backend_service_memory" {
  description = "The memory for the backend service"
  type        = number
  default     = 512
}

variable "backend_service_port" {
  description = "The port for the backend service"
  type        = number
  default     = 3000
}

variable "frontend_service_cpu" {
  description = "The CPU units for the frontend service"
  type        = number
  default     = 256
}

variable "frontend_service_memory" {
  description = "The memory for the frontend service"
  type        = number
  default     = 512
}

variable "frontend_service_port" {
  description = "The port for the frontend service"
  type        = number
  default     = 80
}

variable "region" {
  description = "The region for the infrastructure"
  type        = string
  default     = "us-west-2"
}

variable "alb_public_access" {
  description = "Whether the ALB should be publicly accessible"
  type        = bool
  default     = true
}

variable "acm_certificate_arn" {
  description = "The ARN for the ACM certificate"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "backend_readonly_root_filesystem" {
  description = "Whether the backend service should have a read-only root filesystem"
  type        = bool
  default     = true
}

variable "create_env_bucket" {
  description = "Whether to create an environment bucket"
  type        = bool
  default     = false
}

variable "backend_service_environment" {
  description = "Environment variables for the backend service"
  type        = list(map(string))
  default     = null
}

variable "frontend_service_environment" {
  description = "Environment variables for the frontend service"
  type        = list(map(string))
  default     = null
}

variable "db_engine" {
  description = "The engine for the database"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "The version for the database engine"
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "The instance class for the database"
  type        = string
  default     = "db.t3.micro"
}

variable "db_storage_size" {
  description = "The storage size for the database"
  type        = number
  default     = 20
}

variable "db_port" {
  description = "The port for the database"
  type        = number
  default     = 5432
}

variable "db_publicly_accessible" {
  description = "Whether the database should be publicly accessible"
  type        = bool
  default     = false
}

variable "db_parameter_group_family" {
  description = "The family for the database parameter group"
  type        = string
  default     = "mysql8.0"
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot"
  type        = bool
  default     = true
}