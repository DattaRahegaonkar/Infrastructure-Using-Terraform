

output "public_ip" {
  value = aws_instance.terraform_ec2_instance[*].public_ip
}

output "private_ip" {
  value = aws_instance.terraform_ec2_instance[*].private_ip
}

output "public_dns" {
  value = aws_instance.terraform_ec2_instance[*].public_dns
}
