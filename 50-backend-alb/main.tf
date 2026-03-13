# Backend ALB creation
resource "aws_lb" "backend_alb" {
  name               = "${var.project}-${var.environment}" # roboshop-dev
  internal           = true # Because it is private
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = local.private_subnet_ids

  # Keeping it as false, just to delete using terraform while practice
  enable_deletion_protection = false

  tags = merge(
    {
        Name = "${var.project}-${var.environment}"
    },
    local.common_tags
  )
}