# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# For AMI-ID
data "aws_ami" "joindevops" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# For Database Subnet Id ssm parameter store
data "aws_ssm_parameter" "database_subnet_ids" {
    name = "/${var.project}/${var.environment}/database_subnet_ids"     # /roboshop/dev/database_subnet_ids
}

# For MongoDB sg id ssm parameter store
data "aws_ssm_parameter" "mongodb_sg_id" {
    name = "/${var.project}/${var.environment}/mongodb_sg_id"     # /roboshop/dev/mongodb_sg_id
}

# For Redis sg id ssm parameter store
data "aws_ssm_parameter" "redis_sg_id" {
    name = "/${var.project}/${var.environment}/redis_sg_id"     # /roboshop/dev/redis_sg_id
}

# For MySQL sg id ssm parameter store
data "aws_ssm_parameter" "mysql_sg_id" {
    name = "/${var.project}/${var.environment}/mysql_sg_id"     # /roboshop/dev/mysql_sg_id
}

# For Rabbitmq sg id ssm parameter store
data "aws_ssm_parameter" "rabbitmq_sg_id" {
    name = "/${var.project}/${var.environment}/rabbitmq_sg_id"     # /roboshop/dev/rabbitmq_sg_id
}