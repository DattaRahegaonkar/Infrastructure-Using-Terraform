
# dev environment
module "dev-infrastructure" {
  source = "./Infra_Code"
  env = "dev"
  bucket_name = "infra-bucket-by"
  instance_count = 1
  ec2_ami_id = "ami-01f23391a59163da9"
  instance_type = "t2.micro"
  hash_key = "LockID"
}

# stg environment
module "stg-infrastructure" {
  source = "./Infra_Code"
  env = "stg"
  bucket_name = "infra-bucket-by"
  instance_count = 1
  ec2_ami_id = "ami-01f23391a59163da9"
  instance_type = "t2.micro"
  hash_key = "LockID"
}

# prod environment
module "prod-infrastructure" {
  source = "./Infra_Code"
  env = "prod"
  bucket_name = "infra-bucket-by"
  instance_count = 2
  ec2_ami_id = "ami-01f23391a59163da9"
  instance_type = "t2.medium"
  hash_key = "LockID"
}