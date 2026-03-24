locals {
    ami_id = data.aws_ami.openvpn.id
    common_tags = {
        Project     = var.project
        Environment = var.environment
        Terraform   = "true"
    }

    # Public Subnet in us-east-1a  Availability Zone
    public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]    # We get list type here
    openvpn_sg_id    = data.aws_ssm_parameter.openvpn_sg_id.value
}