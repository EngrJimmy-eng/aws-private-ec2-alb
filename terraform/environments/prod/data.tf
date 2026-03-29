# Get existing VPC
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["JimmyTechVPC"]
  }
}

# Get public subnets
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  tags = {
    Name = "Public-*"
  }
}

# Get private subnets
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  tags = {
    Name = "Private-*"
  }
}
