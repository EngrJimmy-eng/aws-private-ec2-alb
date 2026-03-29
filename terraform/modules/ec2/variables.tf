variable "vpc_id" {}

variable "private_subnets" {
  type = list(string)
}

variable "alb_sg_id" {}

variable "target_group_arn" {}

variable "ami" {
  default = "ami-09d0c9a85bf1b9ea7" # Ubuntu (your region)
}

variable "instance_type" {
  default = "t3.micro"
}

variable "name" {
  default = "app-ec2"
}
