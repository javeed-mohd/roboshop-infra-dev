resource "aws_instance" "mongodb" {
  ami                       = local.ami_id
  instance_type             = "t3.micro"
  subnet_id                 = local.database_subnet_id
  vpc_security_group_ids    = [local.mongodb_sg_id]    # List type

  # roboshop-dev-mongodb
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-mongodb"
    },
    local.common_tags
  )
}

resource "aws_iam_role" "bastion" {
  name = "RoboshopDevBastion"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    {
        Name = "RoboshopDevBastion"
    },
    local.common_tags
  )
}

resource "aws_iam_role_policy_attachment" "bastion" {
  role       = aws_iam_role.bastion.name
  # policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create the instance profile
resource "aws_iam_instance_profile" "bastion" {
  name = "${var.project}-${var.environment}-bastion"
  role = aws_iam_role.bastion.name
}

# mongodb-dev.devopsdaws.online (Route53 records)