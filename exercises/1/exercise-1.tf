terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
  required_version = ">= 0.14.0, < 0.15.0"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_instance" "default" {
  ami           = "ami-0b5247d4d01653d09"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.default.id
  security_groups = [aws_security_group.default.id]
  associate_public_ip_address = true
}

// Network
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

resource "aws_subnet" "default" {
  vpc_id     = aws_vpc.default.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "default" {
  name = "allow-all"
  vpc_id = aws_vpc.default.id

  // Explicitly allow outgoing traffic to anything.  (Terraform removes the default rule for security reasons, AWS does not)
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
}

resource "aws_route_table_association" "default" {
  subnet_id      = aws_subnet.default.id
  route_table_id = aws_route_table.default.id
}
