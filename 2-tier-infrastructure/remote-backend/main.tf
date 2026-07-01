
resource aws_s3_bucket "tf-state-file-bucket" {
  bucket = "terraform-state-file-bucket-30"

  tags = {
    Name = "terraform-state-file-bucket-30"
  }

}

resource aws_s3_bucket_versioning tf-state-file-versioning {

  bucket = aws_s3_bucket.tf-state-file-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
