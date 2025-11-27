variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"   # Free-tier eligible
}

variable "ami_id" {
  type    = string
  default = "ami = "ami-080e1f13689e07408"
}
