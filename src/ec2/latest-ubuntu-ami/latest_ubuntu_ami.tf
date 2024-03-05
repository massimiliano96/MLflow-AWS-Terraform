# Mantainer: Claudio Destro c.destro@crif.com

variable "ubuntu-ami-name" {
  description = "Ubuntu AMI name"
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"
}

data "aws_ami" "ubuntu-ami" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = [var.ubuntu-ami-name]
  }
}

output "ubuntu" {
  value = data.aws_ami.ubuntu-ami.id
}
