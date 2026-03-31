
# -----------------------------
# ALB Module
# -----------------------------
module "alb" {
  source = "../../modules/alb"

  name            = "app-alb"
  vpc_id          = data.aws_vpc.main.id
  public_subnets  = data.aws_subnets.public.ids
}

# -----------------------------
# EC2 Module
# -----------------------------
module "ec2" {
  source = "../../modules/ec2"

  name             = "my-app"
  ami              = "ami-12345678"   # 🔁 replace with real AMI
  instance_type    = "t3.micro"

  vpc_id           = data.aws_vpc.main.id
  private_subnets  = data.aws_subnets.private.ids

  alb_sg_id        = aws_security_group.alb_sg.id
  target_group_arn = aws_lb_target_group.app.arn
}
