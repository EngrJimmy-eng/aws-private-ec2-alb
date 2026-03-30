
# Get Existing VPC

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["JimmyTechVPC"]
  }
}


# Get Public Subnets

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["Public-*"]
  }
}

# -----------------------------
# Get Private Subnets
# -----------------------------
data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["Private-*"]
  }
}

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

  name              = "app-ec2"
  vpc_id            = data.aws_vpc.main.id
  subnet_id         = data.aws_subnets.private.ids[0]
  alb_sg_id         = module.alb.alb_sg_id
  target_group_arn  = module.alb.target_group_arn
}
