resource "aws_security_group_rule" "bastion_internet" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  # cidr_blocks              = [local.my_ip] # Public_ip keeps changing with mobile hotspot 
  #   For which security group you are creating this rule.
  security_group_id        = local.bastion_sg_id 
}

# For MongoDB Security Group Rule creation
resource "aws_security_group_rule" "mongodb_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
#   Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.mongodb_sg_id 
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
#   Where traffic is coming from?
  source_security_group_id = local.catalogue_sg_id
  security_group_id        = local.mongodb_sg_id 
}

resource "aws_security_group_rule" "mongodb_user" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
#   Where traffic is coming from?
  source_security_group_id = local.user_sg_id
  security_group_id        = local.mongodb_sg_id
}

# For Redis Security Group Rule creation in 40-databases folder
resource "aws_security_group_rule" "redis_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
#   Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.redis_sg_id 
}

# For MySQL Security Group Rule creation in 40-databases folder
resource "aws_security_group_rule" "mysql_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
#   Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.mysql_sg_id 
}

# For RabbitMQ Security Group Rule creation in 40-databases folder
resource "aws_security_group_rule" "rabbitmq_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
#   Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.rabbitmq_sg_id 
}

# For Backend ALB(Application LoadBalancer) Security Group Rule creation in 50-backend-alb folder
resource "aws_security_group_rule" "backend_alb_bastion" {
  type                     = "ingress"
  from_port                = 80 # HTTP (Private LoadBalancer)
  to_port                  = 80
  protocol                 = "tcp"
#   Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.backend_alb_sg_id
}