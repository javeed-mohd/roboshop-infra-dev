# Creation of AWS Certificate Manager(ACM)
resource "aws_acm_certificate" "roboshop" {
  domain_name       = "*.${var.domain_name}"    # *.devopsdaws.online
  validation_method = "DNS"

  # roboshop-dev-devopsdaws.online
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-${var.domain_name}"
    },
    local.common_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

# Creation of Route53 records for validation of AWS Certificate Manager(ACM)
resource "aws_route53_record" "roboshop" {
  for_each = {
    for dvo in aws_acm_certificate.roboshop.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

# Validation for AWS Certificate Manager(ACM) Certificate
resource "aws_acm_certificate_validation" "roboshop" {
  certificate_arn         = aws_acm_certificate.roboshop.arn
  validation_record_fqdns = [for record in aws_route53_record.roboshop : record.fqdn]
}