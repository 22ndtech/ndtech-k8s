provider "aws" {
  region = "us-west-2"
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
    key = "prod/backend-storage/terraform.tfstate"
  }
}