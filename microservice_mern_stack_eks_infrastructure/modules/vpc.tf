resource "aws_vpc" "projectX-vpc" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${local.cluster_name}-main-vpc"
  }
}

#CLUSTER SECURITY GROUP
resource "aws_security_group" "eks-cluster-sg" {
  name        = var.cluster-sg-name
  description = "Allow 443 from bastion host"

  vpc_id = aws_vpc.projectX-vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.cluster-sg-name
  }
}