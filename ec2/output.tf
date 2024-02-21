output "instance_id" {
  value = aws_instance.ec2_tracking_server[*].id
}

output "private_ip" {
  value = aws_instance.ec2_tracking_server[*].private_ip
}

output "public_ip" {
  value = aws_instance.ec2_tracking_server[*].public_ip
}

output "name" {
  value = aws_instance.ec2_tracking_server[*].tags
}

output "ec2_public_dns" {
  value = aws_instance.ec2_tracking_server[*].public_dns
}