resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.projectX-vpc.id

  tags = {
    Name                                          = "${local.cluster_name}-vpc-igw"
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }

  depends_on = [aws_vpc.projectX-vpc]
}

