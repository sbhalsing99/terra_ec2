terraform {
  backend "s3" {
    bucket         = "shruti-tf-backend-bucket"
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
  }
}