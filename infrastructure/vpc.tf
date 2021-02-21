module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.71.0"

  name = "dev.myonlinebookstore.vpc"

  cidr = "20.10.0.0/16"

  azs                 = ["us-east-1a", "us-east-1b"]
  private_subnets     = ["20.10.1.0/24", "20.10.2.0/24"]
  public_subnets      = ["20.10.11.0/24", "20.10.12.0/24"]
  database_subnets    = ["20.10.21.0/24", "20.10.22.0/24"]
  # elasticache_subnets = ["20.10.31.0/24", "20.10.32.0/24"]

  create_database_subnet_group = false

  # Used for private endpoints.
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false

  # VPC endpoint for S3.
  enable_s3_endpoint = true

  # VPC endpoint for SSM.
  enable_ssm_endpoint              = true
  ssm_endpoint_private_dns_enabled = true
  ssm_endpoint_security_group_ids  = [module.sg_http.this_security_group_id]

  # VPC Endpoint for EC2.
  enable_ec2_endpoint              = true
  ec2_endpoint_private_dns_enabled = true
  ec2_endpoint_security_group_ids  = [module.sg_http.this_security_group_id]

  # Default security group - ingress/egress rules cleared to deny all
  manage_default_security_group  = true
  default_security_group_ingress = [{}]
  default_security_group_egress  = [{}]

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  tags = var.tags
}
