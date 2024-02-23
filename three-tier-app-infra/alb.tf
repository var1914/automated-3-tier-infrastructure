module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name = "${local.prefix}-alb"

  load_balancer_type    = "application"
  internal              = var.alb_public_access
  vpc_id                = module.vpc.vpc_id
  subnets               = module.vpc.public_subnets
  create_security_group = true
  security_group_ingress_rules = {
    all_http = {
      description = "Allow HTTP ingress"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }

    all_https = {
      description = "Allow HTTPS ingress"
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  target_groups = {
    frontend = {
      protocol    = "HTTP"
      port        = 80
      target_type = "ip"
      target_id   = "http"
      health_check = {
        path                = "/"
        interval            = 30
        timeout             = 15
        healthy_threshold   = 5
        unhealthy_threshold = 5
        matcher             = "200"
      }
    }
  }
  listeners = {
    http_tcp_listeners = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    # https_listeners = {
    #   port               = 443
    #   protocol           = "HTTPS"
    #   certificate_arn    = "${var.acm_certificate_arn}"
    #   forward = {
    #     target_group_key = "frontend"
    #   }
    # }
  }
  tags = local.tags
}