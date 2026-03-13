resource "aws_lb" "backend_alb" {
  name               = "${var.project}-${var.environment}" # roboshop-dev
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = local.private_subnet_ids

  # keeping it as false, just to delete using terraform while practice
  enable_deletion_protection = true

  tags = merge(
    {
        Name = "${var.project}-${var.environment}"
    },
    local.common_tags
  )
}