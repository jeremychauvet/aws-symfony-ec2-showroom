data "aws_route53_zone" "primary" {
  name = "${var.route53_zone}."
}

# ELB alias.
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "hello.${var.route53_zone}"
  type    = "A"

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}

# Bastion.
resource "aws_route53_record" "bastion" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "bastion.${var.route53_zone}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.bastion.public_ip]
}
