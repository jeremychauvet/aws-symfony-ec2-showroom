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
