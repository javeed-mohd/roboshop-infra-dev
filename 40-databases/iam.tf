# For Mysql, We create a IAM Role
resource "aws_iam_role" "mysql" {
  name = local.mysql_role_name # Roboshop-Dev-Mysql

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
        Name = local.mysql_role_name
    },
    local.common_tags
  )
}

# Creating the IAM Role Policy
resource "aws_iam_policy" "mysql" {
  name        = local.mysql_policy_name
  description = "A policy for MySQL EC2 Instance"
  policy      = templatefile("mysql-iam-policy.json", {
                environment = var.environment
  })
}

# Attaching the IAM Role Policy
resource "aws_iam_role_policy_attachment" "mysql" {
  role        = aws_iam_role.mysql.name
  policy_arn  = aws_iam_policy.mysql.arn
}

# Creating the IAM Instance Profile
resource "aws_iam_role_policy_attachment" "mysql" {
  role       = aws_iam_role.mysql.name
  policy_arn = aws_iam_policy.mysql.arn
}