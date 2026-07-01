terraform {
  backend "s3" {
    bucket         = "terraform-state-file-bucket-30"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    use_lockfile   = true
  }
}