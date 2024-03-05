resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "main_public" {
  vpc_id               = aws_vpc.main.id
  availability_zone    = var.availability_zone_subnet
  cidr_block           = "10.0.1.0/24"  
  map_public_ip_on_launch = true
  tags = {
    Name = "main-public-subnet"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id               = aws_vpc.main.id
  availability_zone    = var.availability_zones_private_subnets[0]
  cidr_block           = "10.0.2.0/24" 
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id               = aws_vpc.main.id
  availability_zone    = var.availability_zones_private_subnets[1]
  cidr_block           = "10.0.3.0/24"  
  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id               = aws_vpc.main.id
  availability_zone    = var.availability_zones_private_subnets[2]
  cidr_block           = "10.0.4.0/24"  
  tags = {
    Name = "private-subnet-3"
  }
}

resource "aws_security_group" "mlflow_sg" {
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [aws_subnet.main_public.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main-security-group"
  }
}

resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_internet_gateway.id
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.main_public.id
  route_table_id = aws_route_table.public_route_table.id
}