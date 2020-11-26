provider "aws" {
  version = ">= 2.28.1"
  region  = "us-west-2"
}

variable "region" {
  default     = "us-west-2"
  description = "AWS region"
}

locals {
  cluster_name = "prod-aws-ndtech-k8s-cluster"
}

# store tfstate in s3 and locking information in DynamoDB
terraform {
  backend "s3" {
    encrypt = true
    # cannot contain interpolations
    # bucket = "${aws_s3_bucket.terraform-state-storage-s3.bucket}"
    bucket = "prod-ndtech-tfstate"
    # region = "${aws_s3_bucket.terraform-state-storage-s3.region}"
    region = "us-west-2"
    dynamodb_table = "prod-ndtech-tfstate-lock"
    key = "prod/aws/ndtech-k8s-cluster/terraform.tfstate"
  }
}