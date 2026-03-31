
# Security Group for EC2

resource "aws_security_group" "ec2_sg" {
  name        = "${var.name}-sg"
  description = "Allow traffic from ALB only"
  vpc_id      = var.vpc_id

  # Allow HTTP ONLY from ALB
  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  # Allow all outbound traffic (for updates, package installs, etc.)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}





# Attach EC2 to Target Group

resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.app.id
  port             = 80
}
