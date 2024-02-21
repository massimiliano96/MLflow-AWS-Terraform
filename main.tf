provider "aws" {
  region = var.aws_region
}

module "mlflow_vpc" {
  source = "./network"
  availability_zones_private_subnets = var.availability_zones_private_subnets
}

module "iam_role" {
  source = "./iam"
  s3_arn = module.artifact_storage.s3_arn
}

module "metadata_storage" {
  source = "./rds"
  security_group_ids = module.mlflow_vpc.sg_id
  subnet_ids = module.mlflow_vpc.private_subnets_ids
}

module "artifact_storage" {
  source = "./s3"
}

module "tracking_server" {
  source = "./ec2"
  region = var.aws_region
  assume_role = true
  iam_role = module.iam_role.name
  subnet_id = module.mlflow_vpc.subnet_id
  security_group = module.mlflow_vpc.sg_id
  s3_bucket = module.artifact_storage.s3_name
  db_endpoint = module.metadata_storage.db_endpoint
  db_name = module.metadata_storage.db_name
  db_username = module.metadata_storage.db_username
  db_password = module.metadata_storage.db_password
}