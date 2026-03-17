# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# AMI-ID data source
data "http" "my_public_ip_v4" {
  url = "https://ipv4.icanhazip.com"
}

output "my_ipv4_address" {
  value = chomp(data.http.my_public_ip_v4.response_body)
}

# BASTION SG Id data source
# A bastion host is a special server that acts as a secure gateway to access resources inside a private network (like private VMs or instances)
data "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project}/${var.environment}/bastion_sg_id"       # /roboshop/dev/bastion_sg_id
}

# MONGODB SG Id data source
data "aws_ssm_parameter" "mongodb_sg_id" {
    name = "/${var.project}/${var.environment}/mongodb_sg_id"       # /roboshop/dev/mongodb_sg_id
}

# REDIS SG Id data source
data "aws_ssm_parameter" "redis_sg_id" {
    name = "/${var.project}/${var.environment}/redis_sg_id"         # /roboshop/dev/redis_sg_id
}

# MySQL SG Id data source
data "aws_ssm_parameter" "mysql_sg_id" {
    name = "/${var.project}/${var.environment}/mysql_sg_id"         # /roboshop/dev/mysql_sg_id
}

# RABBITMQ SG Id data source
data "aws_ssm_parameter" "rabbitmq_sg_id" {
    name = "/${var.project}/${var.environment}/rabbitmq_sg_id"      # /roboshop/dev/rabbitmq_sg_id
}

# CATALOGUE SG Id data source
data "aws_ssm_parameter" "catalogue_sg_id" {
    name = "/${var.project}/${var.environment}/catalogue_sg_id"         # /roboshop/dev/catalogue_sg_id
}

# USER SG Id data source
data "aws_ssm_parameter" "user_sg_id" {
    name = "/${var.project}/${var.environment}/user_sg_id"          # /roboshop/dev/user_sg_id
}

# CART SG Id data source
data "aws_ssm_parameter" "cart_sg_id" {
    name = "/${var.project}/${var.environment}/cart_sg_id"          # /roboshop/dev/cart_sg_id
}

# SHIPPING SG Id data source
data "aws_ssm_parameter" "shipping_sg_id" {
    name = "/${var.project}/${var.environment}/shipping_sg_id"          # /roboshop/dev/shipping_sg_id
}

# PAYMENT SG Id data source
data "aws_ssm_parameter" "payment_sg_id" {
    name = "/${var.project}/${var.environment}/payment_sg_id"          # /roboshop/dev/payment_sg_id
}

# BACKEND ALB SG Id data source
data "aws_ssm_parameter" "backend_alb_sg_id" {
    name = "/${var.project}/${var.environment}/backend_alb_sg_id"       # /roboshop/dev/backend_alb_sg_id
}

# FRONTEND SG Id data source
data "aws_ssm_parameter" "frontend_sg_id" {
    name = "/${var.project}/${var.environment}/frontend_sg_id"          # /roboshop/dev/frontend_sg_id
}

# FRONTEND ALB SG Id data source
data "aws_ssm_parameter" "frontend_alb_sg_id" {
    name = "/${var.project}/${var.environment}/frontend_alb_sg_id"      # /roboshop/dev/frontend_alb_sg_id
}