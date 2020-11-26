locals {
  project_id = "jjh1-289322"
  region     = "us-central1"
  cluster_name = "prod-gke-ndtech-k8s-cluster"
}

provider "google" {
  project = local.project_id
  region  = local.region
  credentials = "/ndtech-k8s-admin-key.json"
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
    key = "prod/gke/ndtech-k8s-cluster/terraform.tfstate"
  }
}