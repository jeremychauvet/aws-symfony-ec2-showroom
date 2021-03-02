resource "aws_lb" "http" {
  name                             = "dev-http-elb"
  load_balancer_type               = "network"
  subnets                          = module.vpc.public_subnets
  enable_cross_zone_load_balancing = true
  tags                             = var.tags

  access_logs {
    bucket  = aws_s3_bucket.lb_access_logs.bucket
    prefix  = "lb-logs"
    enabled = true
  }
}

resource "aws_lb_target_group" "http" {
  name     = "dev-http-elb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

# TODO: add target group.
