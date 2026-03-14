# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# For Backend ALB sg id ssm parameter store
data "aws_ssm_parameter" "backend_alb_sg_id" {
    name = "/${var.project}/${var.environment}/backend_alb_sg_id" # /roboshop/dev/backend_alb_sg_id
}

# For Private Subnet Id ssm parameter store
data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project}/${var.environment}/private_subnet_ids"     # /roboshop/dev/private_subnet_ids
}