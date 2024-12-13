resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "${local.cluster_name}-eip"
  }
  depends_on = [aws_vpc.projectX-vpc]
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet[0].id

  tags = {
    Name = "${local.cluster_name}-gw-NAT"
  }

  depends_on = [aws_eip.eip]
}