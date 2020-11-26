# terraform state file setup
# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "prod-ndtech-s3-tfstate" {
  bucket = "prod-ndtech-tfstate"

  versioning {
    # enable with caution, makes deleting S3 buckets tricky
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    name = "S3 Remote Terraform State Store for production ndtech infrastructure"
    proj = "ndtech"
    env = "prod"
  }
}

# create a DynamoDB table for locking the state file
resource "aws_dynamodb_table" "prod-ndtech-tfstate-lock" {
  name = "prod-ndtech-tfstate-lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    name = "Prod DynamoDB Terraform State Lock Table for ndtech"
    proj = "ndtech"
    env = "prod"
  }
}