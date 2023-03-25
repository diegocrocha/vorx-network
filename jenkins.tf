module "jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "Jenkins-SG"
  description         = "Security group for jenkins instance"
  vpc_id              = data.aws_vpc.vorx-vpc-prod.id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["all-all"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = "jenkins-server"
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro"
  key_name               = "vockey"
  monitoring             = true
  vpc_security_group_ids = [module.jenkins_sg.security_group_id]
  subnet_id              = data.aws_subnet.vorx-subnet-pub-1a.id
  user_data              = file("./dependencias.sh")
  iam_instance_profile   = "LabInstanceProfile"

  tags = {
    Name        = "Jenkins-Server"
    Environment = "Prod"
  }
}

resource "aws_eip" "jenkins-ip" {
  instance = module.ec2_instance.id
  vpc      = true
}
