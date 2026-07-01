
output "web_server_public_ip" {
  value = module.ec2_instances.web_server_public_ip
}

output "app_server_private_ip" {
  value = module.ec2_instances.app_server_private_ip
}

output "db_server_private_ip" {
  value = module.ec2_instances.db_server_private_ip
}