module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "dev.myonlinebookstore.vpc"

  cidr = "20.10.0.0/16"

  azs              = ["us-east-1a", "us-east-1b"]
  private_subnets  = ["20.10.1.0/24", "20.10.2.0/24"]
  public_subnets   = ["20.10.11.0/24", "20.10.12.0/24"]
  database_subnets = ["20.10.21.0/24", "20.10.22.0/24"]

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
