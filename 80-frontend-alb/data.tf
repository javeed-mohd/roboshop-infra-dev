# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# Frontend ALB SG Id data source
data "aws_ssm_parameter" "frontend_alb_sg_id" {
    name = "/${var.project}/${var.environment}/frontend_alb_sg_id" # /roboshop/dev/frontend_alb_sg_id
}

# Public Subnet Id data source
data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project}/${var.environment}/public_subnet_ids"     # /roboshop/dev/public_subnet_ids
}

# Fronted ALB Certificate Arn data source
data "aws_ssm_parameter" "frontend_alb_certificate_arn" {
    name = "/${var.project}/${var.environment}/frontend_alb_certificate_arn"    # /roboshop/dev/frontend_alb_certificate_arn
}