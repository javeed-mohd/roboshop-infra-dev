# Listener Rule (Backend ALB) creation for 60-catalogue folder
resource "aws_ssm_parameter" "backend_alb_listener_arn" {
  name  = "/${var.project}/${var.environment}/backend_alb_listener_arn"     # /roboshop/dev/backend_alb_listener_arn
  type  = "String"
  value = aws_lb_listener.http.arn
}