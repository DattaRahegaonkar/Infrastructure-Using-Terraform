
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }


backend "s3" {
  bucket         = "terraform-state-s3-bucket-datta"
  key            = "terraform.tfstate"
  region         = "eu-west-1"
  dynamodb_table = "terraform-state-lock-table"
}
}