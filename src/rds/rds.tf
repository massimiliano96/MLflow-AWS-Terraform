resource "aws_db_subnet_group" "mlflow_db_subnet_group" {
  name       = "mlflow_subnet_group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My ${var.db_name}-DB subnet group"
  }
}

resource "aws_db_instance" "mlflow_metadata_storage" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  skip_final_snapshot  = var.skip_final_snapshot
  vpc_security_group_ids = [var.security_group_ids]
  db_subnet_group_name = aws_db_subnet_group.mlflow_db_subnet_group.name
}