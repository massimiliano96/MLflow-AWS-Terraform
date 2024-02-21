output "tracking_server_public_ip" {
  value = module.tracking_server.public_ip
}

output "tracking_server_public_dns" {
  value = module.tracking_server.ec2_public_dns
}