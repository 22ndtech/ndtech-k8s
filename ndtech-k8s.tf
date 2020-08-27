provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "ndtech-k8s-master" {
  ami           = "ami-037843f6aeb12e236"
  instance_type = "t2.micro"
}
