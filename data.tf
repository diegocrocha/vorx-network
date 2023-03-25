data "aws_vpc" "vorx-vpc-prod" {
  id = aws_vpc.vorx-vpc-prod.id
}

data "aws_subnet" "vorx-subnet-pub-1a" {
  id = aws_subnet.vorx-subnet-pub-1a.id
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}