terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region = var.region
}


resource "aws_instance" "myserver" {
  ami           = "ami-0720cb7af233b0529"
  instance_type = "t3.micro"

  tags = {
    Name = "SampleServer"
  }
}



