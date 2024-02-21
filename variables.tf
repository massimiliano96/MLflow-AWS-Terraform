variable "aws_region" {
  default = "eu-central-1"
}

variable "availability_zones_private_subnets" {
  type    = list(string)
  description = "List of availability zones for private subnets"
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}