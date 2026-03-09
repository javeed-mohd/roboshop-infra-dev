locals {
    ami_id = data.aws_ami.joindevops.id
    common_tags = {
        Project     = var.project
        Environment = var.environment
        Terraform   = "true"
    }

    # Public Subnet in us-east-1a  Availability Zone
    database_subnet_id = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0] # We get list type here
    mongodb_sg_id    = data.aws_ssm_parameter.mongodb_sg_id.value
}