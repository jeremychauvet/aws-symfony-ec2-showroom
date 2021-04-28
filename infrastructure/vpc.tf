module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "dev.myonlinebookstore.vpc"

  cidr = "20.10.0.0/16"

  azs              = ["us-east-1a", "us-east-1b"]
  private_subnets  = ["20.10.1.0/24", "20.10.2.0/24"]
  public_subnets   = ["20.10.11.0/24", "20.10.12.0/24"]
  database_subnets = ["20.10.21.0/24", "20.10.22.0/24"]

  # Do not auto-assign public IP on launch.
  map_public_ip_on_launch = false

  # Internet gateway.
  create_igw = true

  # NAT gateways.
  enable_nat_gateway     = true
  one_nat_gateway_per_az = true
  nat_gateway_tags       = var.tags

  # Used for private endpoints.
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [module.sg_http.this_security_group_id]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = var.tags
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [module.sg_http.this_security_group_id]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = var.tags
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [module.sg_http.this_security_group_id]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = var.tags
}

resource "aws_vpc_endpoint" "kms" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.kms"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [module.sg_http.this_security_group_id]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = var.tags
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ec2"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [module.sg_http.this_security_group_id]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true

  tags = var.tags
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  tags              = var.tags
}
