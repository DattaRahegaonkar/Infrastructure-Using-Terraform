
resource "aws_key_pair" "terraform_key" {
  key_name   = "ec2_terraform_key"
  public_key = file("terraform-ec2-key.pub")
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name          = "my-ec2-instance"
  ami           = "ami-01f23391a59163da9"
  instance_type = "t2.micro"
  key_name      = "ec2_terraform_key"
  subnet_id     = "subnet-0d28e36848cb850c6"

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}