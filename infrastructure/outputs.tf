# VPC
output "elb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.http.dns_name
}

output "route53_dns_name" {
  description = "The DNS public name."
  value       = aws_route53_record.www.name
}
