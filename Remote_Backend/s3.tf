
resource "aws_s3_bucket" "state_bucket" {
  bucket = "terraform-state-s3-bucket-datta"

  tags = {
    Name        = "Terraform State Bucket"
  }
}
