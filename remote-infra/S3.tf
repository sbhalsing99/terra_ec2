resource "aws_s3_bucket" "tf_backend_bucket" {
  bucket = "shruti-tf-backend-bucket"
}

resource "aws_dynamodb_table" "tf_state_lock" {
  name         = "terraform-state-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
