provider "aws" {
  region = var.region
}

module "my_ami" {
    source = "../latest-ubuntu-ami"
}

resource "random_pet" "pet_name" {
  length    = 2
  separator = "-"
  count      = var.ec2_count
}

module "my_ssh_key" {
  source = "../ssh-key"
}
resource "aws_iam_instance_profile" "ec2_profile" {
  count = var.assume_role ? var.ec2_count : 0
  name = "${random_pet.pet_name[count.index].id}-ec2-profile"
  role = var.iam_role
}

data "template_file" "ec2_setup" {
  template = file("${path.module}/ec2_setup.tpl")
  
  vars = {
    s3_bucket = var.s3_bucket
    db_endpoint   = var.db_endpoint
    db_name = var.db_name
    db_username = var.db_username
    db_password = var.db_password
  }
}

resource "aws_instance" "ec2_tracking_server" { 
  ami = module.my_ami.ubuntu
  instance_type = var.instace_type
  key_name = module.my_ssh_key.key_name
  count = var.ec2_count
  vpc_security_group_ids = [var.security_group]
  subnet_id = var.subnet_id
  iam_instance_profile = aws_iam_instance_profile.ec2_profile[count.index].name
  tags = {
    "Name" = "mlflow-server-${random_pet.pet_name[count.index].id}"
  }
  user_data = data.template_file.ec2_setup.rendered
}