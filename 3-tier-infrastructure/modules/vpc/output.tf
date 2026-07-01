
output "vpc_id" {
  value = aws_vpc.tf-vpc.id
}

output "public_subnet" {
  value = aws_subnet.tf-public-subnet.id
}

output "private_subnet_1" {
  value = aws_subnet.tf-private-subnet-1.id
}

output "private_subnet_2" {
  value = aws_subnet.tf-private-subnet-2.id
}
