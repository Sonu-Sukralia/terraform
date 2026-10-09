resource "aws_instance" "web" {
    ami           = "ami-0720cb7af233b0529"
    instance_type = "t3.micro"
    count = 2

    tags = {
        name = "hello"
    }

}

provider "aws" {
    region = "ap-southeast-2"
}

# terraform init
# terraform validate
# terraform plan
# terraform apply