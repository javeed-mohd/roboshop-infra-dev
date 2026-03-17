# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# VPC-ID data source
data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project}/${var.environment}/vpc_id"      # /roboshop/dev/vpc_id
}