
output "web_server_public_ip" {
  value = aws_instance.tf-web-server.public_ip
}

output "app_server_private_ip" {
  value = aws_instance.tf-app-server.private_ip
}

output "db_server_private_ip" {
  value = aws_instance.tf-db-server.private_ip
}