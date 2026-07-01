resource "aws_s3_bucket" "tf_bucket" {
  bucket = "3-tier-state-file-bucket"

  tags = {
    Name        = "terraform-bucket"
  }
}

resource "aws_s3_bucket_versioning" "tf_bucket_versioning" {
  bucket = aws_s3_bucket.tf_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}