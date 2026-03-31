
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
  ami              = "ami-12345678"
  instance_type    = "t3.micro"

  vpc_id           = data.aws_vpc.main.id
  private_subnets  = data.aws_subnets.private.ids

  # ✅ FIXED — use module outputs
  alb_sg_id        = module.alb.alb_sg_id
  target_group_arn = module.alb.target_group_arn
}
