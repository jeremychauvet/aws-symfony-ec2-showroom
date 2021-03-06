module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.71.0"

  name = "dev.myonlinebookstore.vpc"

  cidr = "20.10.0.0/16"

  azs              = ["us-east-1a", "us-east-1b"]
  private_subnets  = ["20.10.1.0/24", "20.10.2.0/24"]
  public_subnets   = ["20.10.11.0/24", "20.10.12.0/24"]
  database_subnets = ["20.10.21.0/24", "20.10.22.0/24"]
  # elasticache_subnets = ["20.10.31.0/24", "20.10.32.0/24"]

  create_database_subnet_group = false
  create_igw                   = false

  # Used for private endpoints.
  enable_dns_hostnames = true
  enable_dns_support   = true

  # VPC endpoint for S3.
  enable_s3_endpoint = false

  # VPC endpoint for SSM.
  enable_ssm_endpoint              = false
  ssm_endpoint_private_dns_enabled = true
  ssm_endpoint_security_group_ids  = [module.sg_http.this_security_group_id]

  # VPC Endpoint for EC2.
  enable_ec2_endpoint              = false
  ec2_endpoint_private_dns_enabled = true
  ec2_endpoint_security_group_ids  = [module.sg_http.this_security_group_id]

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  tags = var.tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

resource "aws_eip" "eip_natgateway_aza" {
  vpc = true
}

resource "aws_nat_gateway" "natgateway_aza" {
  allocation_id = aws_eip.eip_natgateway_aza.id
  subnet_id     = module.vpc.private_subnets[0]
}
