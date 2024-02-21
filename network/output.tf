output "vpc_id" {
    value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.main_public.id
}

output "sg_id" {
  value = aws_security_group.mlflow_sg.id
}

output "private_subnets_ids" {
  value = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
    aws_subnet.private_subnet_3.id,
  ]
}