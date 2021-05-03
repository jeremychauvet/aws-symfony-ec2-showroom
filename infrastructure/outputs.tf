# VPC
output "elb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.main.dns_name
}

output "route53_dns_name" {
  description = "The DNS public name."
  value       = aws_route53_record.www.name
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "ami_id" {
  value = data.aws_ami.symfony_web_image.id
}
