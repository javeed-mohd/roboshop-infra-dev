# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# AMI-ID Openvpn data source
data "aws_ami" "openvpn" {
  most_recent      = true
  owners           = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-8fbe3379-*"]
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

# Public Subnet Id data source
data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project}/${var.environment}/public_subnet_ids"     # /roboshop/dev/public_subnet_ids
}

# Openvpn SG Id data source
data "aws_ssm_parameter" "openvpn_sg_id" {
    name = "/${var.project}/${var.environment}/openvpn_sg_id"     # /roboshop/dev/openvpn_sg_id
}