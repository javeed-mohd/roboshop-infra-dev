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

# For Catalogue sg id ssm parameter store
data "aws_ssm_parameter" "catalogue_sg_id" {
    name = "/${var.project}/${var.environment}/catalogue_sg_id"     # /roboshop/dev/catalogue_sg_id
}

# For VPC id ssm parameter store
# data "aws_ssm_parameter" "vpc_id" {
#     name = "/${var.project}/${var.environment}/vpc_id"     # /roboshop/dev/vpc_id
# }

# For Private Subnet Id ssm parameter store
data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project}/${var.environment}/private_subnet_ids"     # /roboshop/dev/private_subnet_ids
}