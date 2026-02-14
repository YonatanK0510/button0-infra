locals {
  terraform_state_bucket = coalesce(
    var.bucket_name,
    "${var.project_name}-terraform-state-${data.aws_caller_identity.current.account_id}"
  )

  terraform_lock_table = coalesce(
    var.dynamodb_table_name,
    "${var.project_name}-terraform-locks"
  )
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = local.terraform_state_bucket
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
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_dynamodb_table" "terraform_locks" {
  name           = local.terraform_lock_table
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
data "aws_caller_identity" "current" {}