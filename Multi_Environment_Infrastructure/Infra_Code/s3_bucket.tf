
resource "aws_s3_bucket" "state_bucket" {
  bucket = "${var.env}-${var.bucket_name}"

  tags = {
    Name        = "${var.env}-${var.bucket_name}"
    environment = var.env
  }
}
