# Security groups
module "sg_http" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "dev.allow-http.sg"
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id

  # Ingress (inbound).
  ingress_cidr_blocks              = ["0.0.0.0/0"]
  computed_ingress_rules           = ["http-80-tcp", "https-443-tcp"]
  number_of_computed_ingress_rules = 2

  # Egress (outbound).
  egress_cidr_blocks              = ["0.0.0.0/0"]
  computed_egress_rules           = ["http-80-tcp", "https-443-tcp"]
  number_of_computed_egress_rules = 2

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.sg_bastion.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}

module "sg_bastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "dev.bastion.sg"
  description = "Security group that allow only SSH, HTTP for Ubuntu updates and HTTPS for SSM."
  vpc_id      = module.vpc.vpc_id

  # Ingress (inbound).
  ingress_cidr_blocks              = ["0.0.0.0/0"]
  computed_ingress_rules           = ["ssh-tcp", "https-443-tcp", "http-80-tcp"]
  number_of_computed_ingress_rules = 3

  # Egress (outbound).
  egress_cidr_blocks              = ["0.0.0.0/0"]
  computed_egress_rules           = ["ssh-tcp", "https-443-tcp", "http-80-tcp"]
  number_of_computed_egress_rules = 3
}


resource "aws_launch_configuration" "symfony" {
  image_id      = data.aws_ami.symfony_web_image.id
  instance_type = var.instance_type
  key_name      = "bastion"
  name          = "Symfony web server"

  iam_instance_profile = aws_iam_instance_profile.asg.arn
  security_groups      = [module.sg_http.this_security_group_id]

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
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

# Bastion
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  key_name                    = "bastion"
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.sg_bastion.this_security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  tags = merge(var.tags, {
    IsAvailableForChaosMonkey = "false"
  })
  root_block_device {
    encrypted = true
  }
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  #checkov:skip=CKV_AWS_88:EC2 instance should not have public IP
}
