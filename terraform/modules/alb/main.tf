########################################
# EXISTING ALB SECURITY GROUP (DATA SOURCE)
########################################
data "aws_security_group" "alb_sg" {
  name   = "app-alb-sg"
  vpc_id = var.vpc_id
}

########################################
# Random ID for Target Group (to avoid duplicates)
########################################
resource "random_id" "tg" {
  byte_length = 2
}

########################################
# Target Group (NEW - Terraform managed)
########################################
resource "aws_lb_target_group" "tg" {
  name     = "app-alb-tg-${random_id.tg.hex}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }
}

########################################
# EXISTING ALB (DATA SOURCE)
########################################
data "aws_lb" "alb" {
  name = "app-alb"
}

########################################
# ALB LISTENER (HTTP → TARGET GROUP)
########################################
resource "aws_lb_listener" "http" {
  load_balancer_arn = data.aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}



