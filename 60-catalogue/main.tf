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