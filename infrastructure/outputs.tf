# VPC
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "elb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.http.dns_name
}
