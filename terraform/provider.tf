provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "JimmyTech"
      Environment = "prod"
      ManagedBy   = "Terraform"
    }
  }
}
