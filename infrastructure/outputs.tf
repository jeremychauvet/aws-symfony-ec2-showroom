# VPC
output "elb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.main.dns_name
}

output "route53_dns_name" {
  description = "The DNS public name."
  value       = aws_route53_record.www.name
}

output "private_route_table_aza" {
  description = "Private route table AZa"
  value       = module.vpc.private_route_table_ids[0]
}

output "natgw_ids_aza" {
  description = "NAT gateway AZa"
  value       = module.vpc.natgw_ids[0]
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "ami_id" {
  value = data.aws_ami.symfony_web_image.id
}
