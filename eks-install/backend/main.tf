# Cloud provider to tell terraform where to create resources
provider "aws" {
  region = "us-east-1"
}

# Resource to tell which resource to create like S3, DynamoDB etc.,
resource "aws_s3_bucket" "terraform_state" {
  bucket = "dso-terraform-eks-state-s3-bucket"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_kms_key" "dynamodb_key" {
  description             = "KMS key for DynamoDB Terraform lock table"
  deletion_window_in_days = 7
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "dso-terraform-eks-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.dynamodb_key.arn
  }

  point_in_time_recovery {
    enabled = true
  }
}