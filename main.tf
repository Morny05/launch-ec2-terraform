terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "enter you access key" # Replace with environment variable for security
  secret_key = "enter your secret key" # Replace with environment variable for security
}

resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

variable "key_name" {
  default = "key-morny" # Use the name of the manually created key pair
}

resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = "${var.key_name}_private_key.pem"
}

resource "aws_instance" "alien" {
  ami           = "ami-0e2c8caa4b6378d8c"
  instance_type = "t2.micro"
  key_name      = var.key_name # Referencing the manually created key pair's name

  tags = {
    Name = "alienooo"
  }
}
