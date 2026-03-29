terraform {
  backend "s3" {
    bucket         = "jimmytech-terraform-state-12345"
    key            = "prod/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
