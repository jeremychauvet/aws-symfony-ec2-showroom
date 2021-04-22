# Security groups
module "sg_http" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "dev.allow-http.sg"
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id

  # Ingress (inbound).
  ingress_cidr_blocks              = ["0.0.0.0/0"]
  computed_ingress_rules           = ["ssh-tcp", "http-80-tcp", "https-443-tcp"]
  number_of_computed_ingress_rules = 3

  # Egress (outbound).
  egress_cidr_blocks              = ["0.0.0.0/0"]
  computed_egress_rules           = ["ssh-tcp", "http-80-tcp", "https-443-tcp"]
  number_of_computed_egress_rules = 3
}

resource "aws_launch_template" "symfony" {
  image_id      = data.aws_ami.symfony_web_image.id
  instance_type = var.instance_type
  key_name      = "symfony"
  update_default_version = true

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2.arn
  }

  network_interfaces {
    security_groups = [module.sg_http.this_security_group_id]
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

resource "aws_launch_configuration" "symfony" {
  image_id      = data.aws_ami.symfony_web_image.id
  instance_type = var.instance_type
  key_name      = "symfony"

  iam_instance_profile = aws_iam_instance_profile.ec2.arn

  security_groups = [module.sg_http.this_security_group_id]

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ebs_encryption_by_default" "main" {
  enabled = true
}

data "aws_ami" "symfony_web_image" {
  most_recent = true
  owners      = ["self"]
  name_regex  = "^symfony-web-image"

  filter {
    name   = "name"
    values = ["symfony-web-image"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
