##########################################
# Provider
##########################################

provider "aws" {
  region = "ap-south-1"
}

##########################################
# VPC & Subnet (default)
##########################################

data "aws_vpc" "default" {
  default = true
}
##########################################
# Security Group
##########################################

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow SSH"

  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

##########################################
# EC2 Instance
##########################################

resource "aws_instance" "my_ec2" {
  ami           = "ami-0f58b397bc5c1f766" # Amazon Linux 2 (Mumbai)
  instance_type = "t2.micro"
  subnet_id     = element(data.aws_subnet_ids.default.ids, 0)
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "my-ec2"
  }
}

##########################################
# Output
##########################################

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}
