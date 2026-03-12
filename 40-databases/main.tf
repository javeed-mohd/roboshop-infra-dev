# MongoDB EC2 Instance
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

# Terraform data/null resource -> Follows standard resource lifecycle(Create, Update & Delete) but won't create any resources.
resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

  # If we want to do remote-exec, we need to have connection.
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }

  # If we want to take some actions (or) run scripts then we can use provisioners.
  # Provisioners will be executed at the time of creation (or) destroy but not at the time of updating the resources.
  provisioner "file" {
    source      = "bootstrap.sh" # Local file path(source)
    destination = "/tmp/bootstrap.sh" # Destination path on remote machine
  }

  # LOCAL EXECUTION  ==> local-exec -> where terraform executes
  # REMOTE EXECUTION ==> remote-exec -> executes inside the resources created by terraform
  # Using Inline command, we can give multiple commands
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb"
    ]
  }
}

# Redis EC2 Instance
resource "aws_instance" "redis" {
  ami                       = local.ami_id
  instance_type             = "t3.micro"
  subnet_id                 = local.database_subnet_id
  vpc_security_group_ids    = [local.redis_sg_id]    # List type

  # roboshop-dev-redis
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-redis"
    },
    local.common_tags
  )
}

# Terraform data/null resource -> Follows standard resource lifecycle(Create, Update & Delete) but won't create any resources.
resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  # If we want to do remote-exec, we need to have connection.
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }

  # If we want to take some actions (or) run scripts then we can use provisioners.
  # Provisioners will be executed at the time of creation (or) destroy but not at the time of updating the resources.
  provisioner "file" {
    source      = "bootstrap.sh" # Local file path(source)
    destination = "/tmp/bootstrap.sh" # Destination path on remote machine
  }

  # LOCAL EXECUTION  ==> local-exec -> where terraform executes
  # REMOTE EXECUTION ==> remote-exec -> executes inside the resources created by terraform
  # Using Inline command, we can give multiple commands
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis"
    ]
  }
}

# MySQL EC2 Instance
resource "aws_instance" "mysql" {
  ami                       = local.ami_id
  instance_type             = "t3.micro"
  subnet_id                 = local.database_subnet_id
  vpc_security_group_ids    = [local.mysql_sg_id]    # List type
  iam_instance_profile      = aws_iam_instance_profile.mysql.name # After creating IAM Instance Profile

  # roboshop-dev-mysql
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-mysql"
    },
    local.common_tags
  )
}

# Terraform data/null resource -> Follows standard resource lifecycle(Create, Update & Delete) but won't create any resources.
resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]

  # If we want to do remote-exec, we need to have connection.
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip
  }

  # If we want to take some actions (or) run scripts then we can use provisioners.
  # Provisioners will be executed at the time of creation (or) destroy but not at the time of updating the resources.
  provisioner "file" {
    source      = "bootstrap.sh" # Local file path(source)
    destination = "/tmp/bootstrap.sh" # Destination path on remote machine
  }

  # LOCAL EXECUTION  ==> local-exec -> where terraform executes
  # REMOTE EXECUTION ==> remote-exec -> executes inside the resources created by terraform
  # Using Inline command, we can give multiple commands
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql ${var.environment}"
    ]
  }
}

# RabbitMQ EC2 Instance
resource "aws_instance" "rabbitmq" {
  ami                       = local.ami_id
  instance_type             = "t3.micro"
  subnet_id                 = local.database_subnet_id
  vpc_security_group_ids    = [local.rabbitmq_sg_id]    # List type

  # roboshop-dev-rabbitmq
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-rabbitmq"
    },
    local.common_tags
  )
}

# Terraform data/null resource -> Follows standard resource lifecycle(Create, Update & Delete) but won't create any resources.
resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]

  # If we want to do remote-exec, we need to have connection.
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip
  }

  # If we want to take some actions (or) run scripts then we can use provisioners.
  # Provisioners will be executed at the time of creation (or) destroy but not at the time of updating the resources.
  provisioner "file" {
    source      = "bootstrap.sh" # Local file path(source)
    destination = "/tmp/bootstrap.sh" # Destination path on remote machine
  }

  # LOCAL EXECUTION  ==> local-exec -> where terraform executes
  # REMOTE EXECUTION ==> remote-exec -> executes inside the resources created by terraform
  # Using Inline command, we can give multiple commands
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq"
    ]
  }
}