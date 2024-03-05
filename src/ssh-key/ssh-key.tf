resource "random_pet" "pet_name" {
  length    = 2
  separator = "-"
}

resource "tls_private_key" "my_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "${random_pet.pet_name.id}-key-pair"
  public_key = tls_private_key.my_key_pair.public_key_openssh
}

resource "null_resource" "saved_private_key" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "${tls_private_key.my_key_pair.private_key_pem}" > key-mlflow-server-${random_pet.pet_name.id}.pem
      chmod 400 ./key-mlflow-server-${random_pet.pet_name.id}.pem
    EOT
  }
}

output "private_key" {
  value       = tls_private_key.my_key_pair.private_key_pem
  description = "Chiave privata generata"
}

output "public_key" {
  value       = aws_key_pair.my_key_pair.public_key
  description = "Chiave pubblica caricata su AWS"
}

output "key_name" {
  value = aws_key_pair.my_key_pair.key_name
}
