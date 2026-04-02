data "aws_security_group" "ec2_sg" {
  name   = "my-app-sg"
  vpc_id = var.vpc_id
}

resource "aws_instance" "app" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.private_subnets[0]
  vpc_security_group_ids = [data.aws_security_group.ec2_sg.id]
  associate_public_ip_address = false

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = var.name
  }
}

resource "time_sleep" "wait_for_instance" {
  depends_on = [aws_instance.app]

  create_duration = "30s"
}

resource "aws_lb_target_group_attachment" "app" {
  depends_on = [time_sleep.wait_for_instance]

  target_group_arn = var.target_group_arn
  target_id        = aws_instance.app.id
  port             = 80
}
