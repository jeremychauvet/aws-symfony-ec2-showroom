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
  name        = "dev-main-alb-aza-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
  }
}

// resource "aws_lb_target_group" "azb" {
//   name        = "dev-main-alb-azb-tg"
//   port        = 80
//   protocol    = "HTTP"
//   target_type = "instance"
//   vpc_id      = module.vpc.vpc_id

//   health_check {
//     port     = 80
//     protocol = "HTTP"
//   }
// }

resource "aws_lb_listener" "https" {
  #checkov:skip=CKV_AWS_103:Ensure that load balancer is using TLS 1.2
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aza.arn
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
