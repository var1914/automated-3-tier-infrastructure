module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name = "${local.prefix}-alb"

  load_balancer_type         = "application"
  internal                   = var.alb_public_access ? false : true
  vpc_id                     = module.vpc.vpc_id
  subnets                    = module.vpc.public_subnets
  create_security_group      = true
  enable_deletion_protection = false
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
    https_listeners = {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = "${var.acm_certificate_arn}"
      forward = {
        arn = aws_lb_target_group.this.arn
      }
    }
  }
  tags = local.tags
}

resource "aws_lb_target_group" "this" {
  name        = "${var.environment}frontend"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
  tags        = local.tags
}