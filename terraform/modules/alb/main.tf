resource "aws_security_group" "alb_sg" {
  # Use the existing name
  name        = "app-alb-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "app-alb-sg"
  }
}
########################################
# Random ID for Target Group
########################################
resource "random_id" "tg" {
  byte_length = 2  # creates 4 hex chars, unique suffix
}

########################################
# Target Group
########################################
resource "aws_lb_target_group" "tg" {
  name     = "app-alb-tg-${random_id.tg.hex}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }

  lifecycle {
    prevent_destroy = true
  }
}

########################################
# Application Load Balancer
########################################
resource "aws_lb" "alb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnets

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "app-alb"
  }
}
