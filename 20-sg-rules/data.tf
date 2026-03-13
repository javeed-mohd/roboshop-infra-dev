# data-source
data "http" "my_public_ip_v4" {
  url = "https://ipv4.icanhazip.com"
}

output "my_ipv4_address" {
  value = chomp(data.http.my_public_ip_v4.response_body)
}

data "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project}/${var.environment}/bastion_sg_id" # /roboshop/dev/bastion_sg_id
}

# For MongoDB ssm parameter store
data "aws_ssm_parameter" "mongodb_sg_id" {
    name = "/${var.project}/${var.environment}/mongodb_sg_id" # /roboshop/dev/mongodb_sg_id
}

# For Redis ssm parameter store in 40-databases folder
data "aws_ssm_parameter" "redis_sg_id" {
    name = "/${var.project}/${var.environment}/redis_sg_id" # /roboshop/dev/redis_sg_id
}

# For MySQL ssm parameter store in 40-databases folder
data "aws_ssm_parameter" "mysql_sg_id" {
    name = "/${var.project}/${var.environment}/mysql_sg_id" # /roboshop/dev/mysql_sg_id
}

# For Rabbitmq ssm parameter store in 40-databases folder
data "aws_ssm_parameter" "rabbitmq_sg_id" {
    name = "/${var.project}/${var.environment}/rabbitmq_sg_id" # /roboshop/dev/rabbitmq_sg_id
}

data "aws_ssm_parameter" "user_sg_id" {
    name = "/${var.project}/${var.environment}/user_sg_id" # /roboshop/dev/user_sg_id
}

# For Backend ALB ssm parameter store in 50-backend-alb folder
data "aws_ssm_parameter" "backend_alb_sg_id" {
    name = "/${var.project}/${var.environment}/backend_alb_sg_id" # /roboshop/dev/backend_alb_sg_id
}

# For Catalogue ssm parameter store in 50-backend-alb folder
data "aws_ssm_parameter" "catalogue_sg_id" {
    name = "/${var.project}/${var.environment}/catalogue_sg_id" # /roboshop/dev/catalogue_sg_id
}