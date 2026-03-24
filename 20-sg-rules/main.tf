# Creation of BASTION Security Group Rule, it should accept connection from internet
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

# Creation of MONGODB Security Group Rule, it should accept connection from bastion
resource "aws_security_group_rule" "mongodb_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.mongodb_sg_id 
}

# Creation of MONGODB Security Group Rule, it should accept connection from catalogue
resource "aws_security_group_rule" "mongodb_catalogue" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.catalogue_sg_id
  security_group_id        = local.mongodb_sg_id 
}

# Creation of MONGODB Security Group Rule, it should accept connection from user
resource "aws_security_group_rule" "mongodb_user" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.user_sg_id
  security_group_id        = local.mongodb_sg_id
}

# Creation of REDIS Security Group Rule, it should accept connection from bastion for 40-databases folder 
resource "aws_security_group_rule" "redis_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.redis_sg_id 
}

# Creation of REDIS Security Group Rule, it should accept connection from user
resource "aws_security_group_rule" "redis_user" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.user_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.redis_sg_id 
}

# Creation of REDIS Security Group Rule, it should accept connection from cart
resource "aws_security_group_rule" "redis_cart" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.cart_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.redis_sg_id 
}

# Creation of MySQL Security Group Rule, it should accept connection from bastion for 40-databases folder
resource "aws_security_group_rule" "mysql_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.mysql_sg_id 
}

# Creation of MySQL Security Group Rule, it should accept connection from shipping
resource "aws_security_group_rule" "mysql_shipping" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.shipping_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.mysql_sg_id 
}

# Creation of RABBITMQ Security Group Rule, it should accept connection from bastion for 40-databases folder
resource "aws_security_group_rule" "rabbitmq_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.rabbitmq_sg_id 
}

# Creation of RABBITMQ Security Group Rule, it should accept connection from payment
resource "aws_security_group_rule" "rabbitmq_payment" {
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.payment_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.rabbitmq_sg_id 
}

# Creation of CATALOGUE Security Group Rule, it should accept connection from bastion for 50-backend-alb folder
resource "aws_security_group_rule" "catalogue_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.catalogue_sg_id 
}

# Creation of CATALOGUE Security Group Rule, it should accept connection from backend_alb for 50-backend-alb folder
resource "aws_security_group_rule" "catalogue_backend_alb" {
  type                     = "ingress"
  from_port                = 8080 # catalogue port number
  to_port                  = 8080
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.backend_alb_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.catalogue_sg_id 
}

# Creation of USER Security Group Rule, it should accept connection from bastion for 50-backend-alb folder
resource "aws_security_group_rule" "user_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.user_sg_id 
}

# Creation of USER Security Group Rule, it should accept connection from backend_alb for 50-backend-alb folder
resource "aws_security_group_rule" "user_backend_alb" {
  type                     = "ingress"
  from_port                = 8080 # user port number
  to_port                  = 8080
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.backend_alb_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.user_sg_id 
}

# Creation of CART Security Group Rule, it should accept connection from bastion for 50-backend-alb folder
resource "aws_security_group_rule" "cart_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.cart_sg_id 
}

# Creation of CART Security Group Rule, it should accept connection from backend_alb for 50-backend-alb folder
resource "aws_security_group_rule" "cart_backend_alb" {
  type                     = "ingress"
  from_port                = 8080 # cart port number
  to_port                  = 8080
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.backend_alb_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.cart_sg_id 
}

# Creation of SHIPPING Security Group Rule, it should accept connection from bastion for 50-backend-alb folder
resource "aws_security_group_rule" "shipping_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.shipping_sg_id 
}

# Creation of SHIPPING Security Group Rule, it should accept connection from backend_alb for 50-backend-alb folder
resource "aws_security_group_rule" "shipping_backend_alb" {
  type                     = "ingress"
  from_port                = 8080 # shipping port number
  to_port                  = 8080
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.backend_alb_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.shipping_sg_id 
}

# Creation of PAYMENT Security Group Rule, it should accept connection from bastion for 50-backend-alb folder
resource "aws_security_group_rule" "payment_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.payment_sg_id 
}

# Creation of PAYMENT Security Group Rule, it should accept connection from backend_alb for 50-backend-alb folder
resource "aws_security_group_rule" "payment_backend_alb" {
  type                     = "ingress"
  from_port                = 8080 # payment port number
  to_port                  = 8080
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.backend_alb_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.payment_sg_id 
}

# Creaion of BACKEND ALB (Application Load Balancer) Security Group Rule, it should accept connection from bastion for 50-backend-alb folder
resource "aws_security_group_rule" "backend_alb_bastion" {
  type                     = "ingress"
  from_port                = 80 # HTTP (LoadBalancer), Because AWS won't give access to SSH 22
  to_port                  = 80
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.backend_alb_sg_id
}

# Creaion of BACKEND ALB (Application Load Balancer) Security Group Rule, it should accept connection from catalogue for 50-backend-alb folder
resource "aws_security_group_rule" "backend_alb_catalogue" {
  type                     = "ingress"
  from_port                = 80 # HTTP (LoadBalancer), Because AWS won't give access to SSH 22
  to_port                  = 80
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.catalogue_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.backend_alb_sg_id
}

# Creaion of BACKEND ALB (Application Load Balancer) Security Group Rule, it should accept connection from user for 50-backend-alb folder
resource "aws_security_group_rule" "backend_alb_user" {
  type                     = "ingress"
  from_port                = 80 # HTTP (LoadBalancer), Because AWS won't give access to SSH 22
  to_port                  = 80
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.user_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.backend_alb_sg_id
}

# Creaion of BACKEND ALB (Application Load Balancer) Security Group Rule, it should accept connection from cart for 50-backend-alb folder
resource "aws_security_group_rule" "backend_alb_cart" {
  type                     = "ingress"
  from_port                = 80 # HTTP (LoadBalancer), Because AWS won't give access to SSH 22
  to_port                  = 80
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.cart_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.backend_alb_sg_id
}

# Creaion of BACKEND ALB (Application Load Balancer) Security Group Rule, it should accept connection from shipping for 50-backend-alb folder
resource "aws_security_group_rule" "backend_alb_shipping" {
  type                     = "ingress"
  from_port                = 80 # HTTP (LoadBalancer), Because AWS won't give access to SSH 22
  to_port                  = 80
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.shipping_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.backend_alb_sg_id
}

# Creaion of BACKEND ALB (Application Load Balancer) Security Group Rule, it should accept connection from payment for 50-backend-alb folder
resource "aws_security_group_rule" "backend_alb_payment" {
  type                     = "ingress"
  from_port                = 80 # HTTP (LoadBalancer), Because AWS won't give access to SSH 22
  to_port                  = 80
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.payment_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.backend_alb_sg_id
}

# Creaion of BACKEND ALB (Application Load Balancer) Security Group Rule, it should accept connection from frontend for 50-backend-alb folder
resource "aws_security_group_rule" "backend_alb_frontend" {
  type                     = "ingress"
  from_port                = 80 # HTTP (LoadBalancer), Because AWS won't give access to SSH 22
  to_port                  = 80
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.frontend_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.backend_alb_sg_id
}

# Creation of FRONTEND Security Group Rule, it should accept connection from bastion
resource "aws_security_group_rule" "frontend_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.frontend_sg_id 
}

# Creation of FRONTEND Security Group Rule, it should accept connection from frontend_alb for 80-frontend-alb folder
resource "aws_security_group_rule" "frontend_frontend_alb" {
  type              = "ingress"
  from_port         = 80 # HTTP (LoadBalancer), Because AWS won't give access to SSH 22
  to_port           = 80
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = local.frontend_alb_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.frontend_sg_id
}

# Creation of FRONTEND ALB (Application Load Balancer) Security Group Rule, it should accept connection from public for 80-frontend-alb folder
resource "aws_security_group_rule" "frontend_alb_public" {
  type              = "ingress"
  from_port         = 443 # HTTPS (LoadBalancer), Because AWS won't give access to SSH 22
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.frontend_alb_sg_id
}

# Creation of Openvpn Security Group Rule, it should accept connection from public 443(outside) for 98-openvpn folder
# OpenVPN is an open-source software application used to create a secure connection over the internet, commonly known as a Virtual Private Network (VPN).
resource "aws_security_group_rule" "openvpn_public_443" {
  type              = "ingress"
  from_port         = 443 # HTTPS (LoadBalancer), Because AWS won't give access to SSH 22
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.openvpn_sg_id
}

# Creation of Openvpn Security Group Rule, it should accept connection from public 943 for 98-openvpn folder
# OpenVPN is an open-source software application used to create a secure connection over the internet, commonly known as a Virtual Private Network (VPN).
# Admin UI (https://public_ip of openvpn instance/admin)
resource "aws_security_group_rule" "openvpn_public_943" {
  type              = "ingress"
  from_port         = 943 # HTTPS (LoadBalancer), Because AWS won't give access to SSH 22
  to_port           = 943
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.openvpn_sg_id
}

# Creation of Backend ALB (Application Load Balancer) Security Group Rule, it should accept connection from openvpn for 98-openvpn folder
# If required, we can provide catalogue_openvpn(8080), user_openvpn(8080), ....
resource "aws_security_group_rule" "backend_alb_openvpn" {
  type                      = "ingress"
  from_port                 = 80 # HTTP (LoadBalancer), Because AWS won't give access to SSH 22
  to_port                   = 80
  protocol                  = "tcp"
  # Where traffic is coming from
  source.security_group_id  = local.openvpn_sg_id # Either cidr block or security group should be used...
  security_group_id         = local.backend_alb_sg_id
}