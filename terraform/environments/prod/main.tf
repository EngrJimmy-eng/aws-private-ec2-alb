module "alb" {
  source = "../../modules/alb"

  vpc_id         = data.aws_vpc.main.id
  public_subnets = data.aws_subnets.public.ids
}

module "ec2" {
  source = "../../modules/ec2"

  name             = "my-app"
  ami              = "ami-12345678"       # replace with your AMI
  instance_type    = "t3.micro"
  vpc_id           = data.aws_vpc.main.id
  private_subnets  = data.aws_subnets.private.ids

  alb_sg_id        = module.alb.alb_sg_id
  target_group_arn = module.alb.target_group_arn
}
