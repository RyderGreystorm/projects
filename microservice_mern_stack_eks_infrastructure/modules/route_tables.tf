#ROUTE TABLES
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.projectX-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.cluster_name}pub-rt"
  }

  depends_on = [aws_vpc.projectX-vpc]
}

resource "aws_route_table" "priv-rt" {
  vpc_id = aws_vpc.projectX-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "${local.cluster_name}priv-rt"
  }

  depends_on = [aws_vpc.projectX-vpc]
}


#Route Table association
resource "aws_route_table_association" "pub-rt-association" {
  count          = 3
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.pub-rt.id

  depends_on = [aws_vpc.projectX-vpc, aws_subnet.public-subnet]
}

resource "aws_route_table_association" "priv-rt-association" {
  count          = 3
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.priv-rt.id

  depends_on = [aws_vpc.projectX-vpc, aws_subnet.private-subnet]
}