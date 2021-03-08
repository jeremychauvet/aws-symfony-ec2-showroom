resource "aws_lb" "main" {
  name               = "dev-main-alb"
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [module.sg_http.this_security_group_id]
  tags               = var.tags

  access_logs {
    bucket  = aws_s3_bucket.lb_access_logs.bucket
    prefix  = "lb"
    enabled = true
  }
}

resource "aws_lb_target_group" "aza" {
  name        = "dev-http-alb-aza-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group" "azb" {
  name        = "dev-http-alb-azb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_lb_listener" "front_end" {
  #checkov:skip=CKV_AWS_2:Ensure ALB protocol is HTTPS
  #checkov:skip=CKV_AWS_103:Ensure that load balancer is using TLS 1.2
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aza.arn
  }
}

resource "aws_lb_listener_rule" "front_end_routing" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.aza.arn
        weight = 50
      }
      target_group {
        arn    = aws_lb_target_group.azb.arn
        weight = 50
      }
    }
  }

  condition {
    host_header {
      values = [aws_route53_record.www.name]
    }
  }
}
