# Catalogue EC2 Instance
resource "aws_instance" "catalogue" {
  ami                       = local.ami_id
  instance_type             = "t3.micro"
  subnet_id                 = local.private_subnet_id
  vpc_security_group_ids    = [local.catalogue_sg_id]

  # roboshop-dev-catalogue
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-catalogue"
    },
    local.common_tags
  )
}

# Terraform data/null resource -> Follows standard resource lifecycle(Create, Update & Delete) but it won't create any resources.
resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  # If we want to do remote-exec, we need to have connection.
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
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
      "sudo sh /tmp/bootstrap.sh catalogue dev"
    ]
  }
}

# For Stopping the EC2 Instance
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [terraform_data.catalogue]
}

# Creating the new EC2 Instance using AMI
resource "aws_ami_from_instance" "catalogue" {
  name               = "${var.project}-${var.environment}-catalogue"
  source_instance_id = aws_instance.catalogue.id
  depends_on         = [aws_ec2_instance_state.catalogue]
  tags  = merge(
    {
      Name = "${var.project}-${var.environment}-catalogue"
    },
    local.common_tags
  )
}

# For Creation of Target Group
resource "aws_lb_target_group" "catalogue" {
  name                  = "${var.project}-${var.environment}-catalogue"
  port                  = 8080 
  protocol              = "HTTP"
  vpc_id                = local.vpc_id
  deregistration_delay  = 60 # Time required for instance termination is 60 seconds

  health_check {
    healthy_threshold   = 2 # Consecutive successes needed to be healthy
    interval            = 10 # Time between health checks (seconds)
    matcher             = "200-299" # HTTP codes for a successful response
    path                = "/health" # The destination path for health checks
    port                = 8080 # Use the port the target receives traffic on
    protocol            = "HTTP" # Protocol for health checks
    timeout             = 2 # Amount of time no response means failure (seconds)
    unhealthy_threshold = 3 # Consecutive failures needed to be unhealthy
    enabled             = true # By default it is true for health checks enabling
  }
}

# For Creation of Launch Template
resource "aws_launch_template" "catalogue" {
  name          = "${var.project}-${var.environment}-catalogue"
  image_id      = aws_ami_from_instance.catalogue.id

  # Once Autoscaling see less traffic, it will automatically terminates the instance(We can also keep stop for some instances)
  instance_initiated_shutdown_behavior = "terminate"
  instance_type           = "t3.micro"
  vpc_security_group_ids  = [local.catalogue_sg_id]

  # Each time we apply terraform, this version will be updated as default
  update_default_version = true

  # Resource tags for instances created by launch template through autoscaling group
  tag_specifications {
    resource_type = "instance"

    # roboshop-dev-catalogue
    tags = merge(
        {
            Name = "${var.project}-${var.environment}-catalogue"
        },
        local.common_tags
    )
  }

  # Resource tags for volumes created by instances
  tag_specifications {
    resource_type = "volume"

    tags = merge(
        {
            Name = "${var.project}-${var.environment}-catalogue"
        },
        local.common_tags
    )
  }

  # Tags for launch template
  tags = merge(
        {
            Name = "${var.project}-${var.environment}-catalogue"
        },
        local.common_tags
    )
}

# For Creation of Autoscaling Group
/* resource "aws_autoscaling_group" "catalogue" {
  name                      = "${var.project}-${var.environment}-catalogue"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 120
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = false # By default, it is true

  launch_template {
    id      = aws_launch_template.catalogue.id
    version = "$Latest"
  }

  vpc_zone_identifier       = [local.private_subnet_id] # We launch in private subnet in 1a availability zone
  target_group_arns         = [aws_lb_target_group.catalogue.arn]

  tag {
    key                 = "Name"
    value               = "${var.project}-${var.environment}-catalogue"
    propagate_at_launch = true
  }

  # Within 15min, Autoscaling should be successful
  timeouts {
    delete = "15m"
  }
} */