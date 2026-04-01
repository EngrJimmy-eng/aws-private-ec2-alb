terraform {
  backend "s3" {
    bucket         = "ikenna-terraform-state"   # 🔁 choose a unique name
    key            = "prod/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
  }
}
