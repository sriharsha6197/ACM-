resource "aws_acm_certificate" "certificate" {
  domain_name       = "harsha.shop"
  validation_method = "DNS"
  tags = {
    Environment = "${var.env}-acm"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "dns_record_acm" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      value = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records          = [each.value.value]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.selected.zone_id
}