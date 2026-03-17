# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# AMI-ID data source
data "http" "my_public_ip_v4" {
  url = "https://ipv4.icanhazip.com"
}

output "my_ipv4_address" {
  value = chomp(data.http.my_public_ip_v4.response_body)
}

data "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project}/${var.environment}/bastion_sg_id"       # /roboshop/dev/bastion_sg_id
}

# MongoDB SG Id data source
data "aws_ssm_parameter" "mongodb_sg_id" {
    name = "/${var.project}/${var.environment}/mongodb_sg_id"       # /roboshop/dev/mongodb_sg_id
}

# Redis SG Id data source
data "aws_ssm_parameter" "redis_sg_id" {
    name = "/${var.project}/${var.environment}/redis_sg_id"         # /roboshop/dev/redis_sg_id
}

# MySQL SG Id data source
data "aws_ssm_parameter" "mysql_sg_id" {
    name = "/${var.project}/${var.environment}/mysql_sg_id"         # /roboshop/dev/mysql_sg_id
}

# Rabbitmq SG Id data source
data "aws_ssm_parameter" "rabbitmq_sg_id" {
    name = "/${var.project}/${var.environment}/rabbitmq_sg_id"      # /roboshop/dev/rabbitmq_sg_id
}

data "aws_ssm_parameter" "user_sg_id" {
    name = "/${var.project}/${var.environment}/user_sg_id"          # /roboshop/dev/user_sg_id
}

# Backend ALB SG Id data source
data "aws_ssm_parameter" "backend_alb_sg_id" {
    name = "/${var.project}/${var.environment}/backend_alb_sg_id"       # /roboshop/dev/backend_alb_sg_id
}

# Catalogue SG Id data source
data "aws_ssm_parameter" "catalogue_sg_id" {
    name = "/${var.project}/${var.environment}/catalogue_sg_id"         # /roboshop/dev/catalogue_sg_id
}

# Frontend ALB SG Id data source
data "aws_ssm_parameter" "frontend_alb_sg_id" {
    name = "/${var.project}/${var.environment}/frontend_alb_sg_id"      # /roboshop/dev/frontend_alb_sg_id
}