variable "instance_class" {
  description = "Instance Class for the Database"
  default = "db.t3.micro"
}

variable "allocated_storage" {
  default = 10
}

variable "db_name" {
  description = "Database Name"
  default = "MlflowMetadataDb"
}

variable "engine" {
  description = "Engine of the RDS Database"
  default = "postgres"
}

variable "engine_version" {
  description = "Version of the Engine"
  default = "16.1"
}

variable "username" {
  default = "Username"
}

variable "password" {
  default = "password"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created."
  default = true
}

variable "security_group_ids" {
  default = null
}

variable "subnet_ids" {
  default = null
}