resource "aws_s3_bucket" "tf_state" {
  bucket = "jimmytech-terraform-state-12345"

  tags = {
    Name = "Terraform State Bucket"
  }
}
