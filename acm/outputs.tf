output "certificate_arn" {
  value = aws_acm_certificate.certificate.arn
}
output "validation_records" {
  value = aws_acm_certificate.certificate.domain_validation_options
}