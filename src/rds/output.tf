output "db_endpoint" {
  value = aws_db_instance.mlflow_metadata_storage.endpoint
}

output "db_username" {
  value = aws_db_instance.mlflow_metadata_storage.username
}

output "db_password" {
  value = aws_db_instance.mlflow_metadata_storage.password
}

output "db_name" {
  value = aws_db_instance.mlflow_metadata_storage.db_name
}