provider "aws" {
  region = "us-east-1"
}

# ────────────────────────────────────────────
# Get Default VPC
# ────────────────────────────────────────────
data "aws_vpc" "default" {
  default = true
}

# ────────────────────────────────────────────
# Get Subnets from Default VPC
# ────────────────────────────────────────────
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ────────────────────────────────────────────
# Security Group
# ────────────────────────────────────────────
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow SSH"
  vpc_id      = data.aws_vpc.default.id

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

# ────────────────────────────────────────────
# EC2 Instance
# ────────────────────────────────────────────
resource "aws_instance" "my_ec2" {
  ami           = "ami-0c02fb55956c7d316" # Latest Amazon Linux 2 for us-east-1
  instance_type = "t2.micro"

  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "my-ec2"
  }
}

# ────────────────────────────────────────────
# Output
# ────────────────────────────────────────────
output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}
