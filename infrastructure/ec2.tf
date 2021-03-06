# Security groups
## HTTP
module "sg_http" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "dev.allow-http.sg"
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_launch_template" "symfony" {
  image_id      = var.ami_id
  instance_type = var.instance_type

  instance_market_options {
    market_type = "spot"
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [module.sg_http.this_security_group_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags          = var.tags
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}
