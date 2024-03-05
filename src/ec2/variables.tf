variable "instace_type" {
  description = "EC2 type"
  default = "t2.micro"
}

variable "ec2_count" {
  description = "Number of EC2 to be created"
  default = 1
}

variable "region" {
  description = "AWS Region"
  default = "eu-central-1"
}

variable "assume_role" {
  description = "Boolean that indicates if a Role need to be attached to the instance"
  default = false
}

variable "iam_role" {
  description = "IAM Role attached to the instance"
  default = null
}

variable "subnet_id" {
  description = "Subnet ID"
  default = "subnet-059124869bc4b8db6"
}


variable "security_group" {
  description = "Security Group"
  default = "sg-05f28ba4b1882f883"
}

variable "s3_bucket" {
  description = "S3 bucket name for the artifact storage"
  default = null
}

variable "db_endpoint" {
  description = "Enpoint of the database of the metadata"
  default = null
}

variable "db_name" {
  description = "Name of the database of the metadata"
  default = null
}

variable "db_username" {
  description = "Username of the database of the metadata"
  default = null
}

variable "db_password" {
  description = "Password of the database of the metadata"
  default = null
}