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
  one_nat_gateway_per_az = true
  nat_gateway_tags       = var.tags

  # Used for private endpoints.
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}

// resource "aws_route_table" "main" {
//   vpc_id = module.vpc.vpc_id

//   route {
//     cidr_block = "0.0.0.0/0"
//     gateway_id = aws_internet_gateway.main.id
//   }

//   tags = var.tags
// }

// resource "aws_route_table_association" "a" {
//   subnet_id      = module.vpc.private_subnets[0]
//   route_table_id = aws_route_table.main.id
// }

// resource "aws_internet_gateway" "main" {
//   vpc_id = module.vpc.vpc_id
//   tags   = var.tags
// }

// resource "aws_eip" "eip_natgateway_aza" {
//   vpc = true
// }

// resource "aws_nat_gateway" "natgateway_aza" {
//   allocation_id = aws_eip.eip_natgateway_aza.id
//   subnet_id     = module.vpc.private_subnets[0]
// }
