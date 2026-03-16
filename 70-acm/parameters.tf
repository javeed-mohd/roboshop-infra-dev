# For Certificate Arn (Frontend ALB) creation in 80-frontend-alb folder
resource "aws_ssm_parameter" "frontend_alb_certificate_arn" {
  name  = "/${var.project}/${var.environment}/frontend_alb_certificate_arn"     # /roboshop/dev/frontend_alb_certificate_arn
  type  = "String"
  value = aws_acm_certificate.roboshop.arn
}