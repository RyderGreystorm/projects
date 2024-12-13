resource "aws_subnet" "private-subnet" {
  count             = length(var.aws_availability_zones)
  vpc_id            = aws_vpc.projectX-vpc.id
  cidr_block        = element(var.priv-sub-cdir-block, count.index)
  availability_zone = element(var.aws_availability_zones, count.index)

  tags = {
    Name                                          = "${local.cluster_name}-vpc-priv-subnet1"
    "kubernetes.io/role/internal-elb"             = "1"
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }
  depends_on = [aws_vpc.projectX-vpc]
}


#PUBLIC SUBNETS

resource "aws_subnet" "public-subnet" {
  count                   = length(var.aws_availability_zones)
  vpc_id                  = aws_vpc.projectX-vpc.id
  cidr_block              = element(var.pub-sub-cdir-block, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.aws_availability_zones, count.index)

  tags = {
    Name                                          = "${local.cluster_name}-vpc-pub-subnet1"
    "kubernetes.io/role/elb"                      = "1"
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }
  depends_on = [aws_vpc.projectX-vpc]
}
