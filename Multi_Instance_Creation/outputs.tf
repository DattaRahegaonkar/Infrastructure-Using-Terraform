
# This output configuration is for count meta-argument usage to create multiple instances.

# output "public_ip" {
#   value = aws_instance.terraform_ec2_instance[*].public_ip
# }

# output "private_ip" {
#   value = aws_instance.terraform_ec2_instance[*].private_ip
# }

# output "public_dns" {
#   value = aws_instance.terraform_ec2_instance[*].public_dns
# }


# This output configuration is for using the for_each meta-argument to create multiple instances.

output "public_ip" {
  value = [
    for instance in aws_instance.terraform_ec2_instance : instance.public_ip
  ]
}

output "public_dns" {
  value = [
    for instance in aws_instance.terraform_ec2_instance : instance.public_dns
  ]
}

output "private_ip" {
  value = [
    for instance in aws_instance.terraform_ec2_instance : instance.private_ip
  ]
}