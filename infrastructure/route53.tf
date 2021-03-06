data "aws_route53_zone" "primary" {
  name = var.route53_zone
}

# ELB alias.
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "hello.${var.route53_zone}"
  type    = "A"

  alias {
    name                   = aws_lb.http.dns_name
    zone_id                = aws_lb.http.zone_id
    evaluate_target_health = true
  }
}
