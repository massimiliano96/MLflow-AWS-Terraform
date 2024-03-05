variable "region" {
    description = "AWS Region"
    default = "eu-central-1"
}

variable "object_ownership" {
  description = "S3 Object ownership when uploaded"
  default = "BucketOwnerPreferred"
}

variable "acl" {
  description = "S3 ACL"
  default = "private"
}