terraform {
  backend "s3" {
    bucket         = "shruti-tf-backend-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock-table"
    encrypt        = true
  }
}
