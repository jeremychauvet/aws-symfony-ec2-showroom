resource "aws_lb" "http" {
  name               = "dev-http-elb"
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [module.sg_http.this_security_group_id]
  tags               = var.tags

  #checkov:skip=CKV_AWS_91:Ensure the ELBv2 (Application/Network) has access logging enabled
  // access_logs {
  //   bucket  = aws_s3_bucket.lb_access_logs.bucket
  //   prefix  = "lb-logs"
  //   enabled = true
  // }
}

resource "aws_lb_target_group" "http" {
  name        = "dev-http-elb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_listener" "front_end" {
  #checkov:skip=CKV_AWS_2:Ensure ALB protocol is HTTPS
  #checkov:skip=CKV_AWS_103:Ensure that load balancer is using TLS 1.2
  load_balancer_arn = aws_lb.http.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}
