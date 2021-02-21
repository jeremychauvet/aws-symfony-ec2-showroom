# HTTP
module "sg_http" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "dev.allow-http.sg"
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}
