resource "aws_vpc" "petclinic" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  tags = {
    Name = "petclinic"
  }
}

#PUBLIC SUBNETS FOR THE AWS VPC

# Subnet 1
resource "aws_subnet" "app1" {
  vpc_id     = aws_vpc.petclinic.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = var.AWS_ZONES["zone1"]
  tags = {
    Name = "app1"
  }
}

# Subnet 2
resource "aws_subnet" "app2" {
  vpc_id     = aws_vpc.petclinic.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = var.AWS_ZONES["zone2"]
  tags = {
    Name = "app2"
  }
}

# Subnet 3
resource "aws_subnet" "app3" {
  vpc_id     = aws_vpc.petclinic.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = var.AWS_ZONES["zone3"]
  tags = {
    Name = "app3"
  }
}


#PRIVATE SUBNETS FOR THE AWS VPC

 #private Subnet 1
resource "aws_subnet" "priv1" {
  vpc_id     = aws_vpc.petclinic.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = var.AWS_ZONES["zone1"]
  tags = {
    Name = "priv1"
  }
}

 #private Subnet 1
resource "aws_subnet" "priv2" {
  vpc_id     = aws_vpc.petclinic.id
  cidr_block = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = var.AWS_ZONES["zone2"]
  tags = {
    Name = "priv2"
  }
}

 #private Subnet 1
resource "aws_subnet" "priv3" {
  vpc_id     = aws_vpc.petclinic.id
  cidr_block = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = var.AWS_ZONES["zone3"]
  tags = {
    Name = "priv3"
  }
}


#CREATE INTERNET GATEWAY FOR VPC
resource "aws_internet_gateway" "petclinic-gw" {
  vpc_id = aws_vpc.petclinic.id

  tags = {
    Name = "petclinic-igw"
  }
}

#ROUTE TABLES

resource "aws_route_table" "petclinic-pub-rt" {
  vpc_id = aws_vpc.petclinic.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.petclinic-gw.id
  }

  tags = {
    Name = "petclinic-rt"
  }
}

#ASSOCIATING ROUTE TABLES WITH SUBNETS

#app1 subnet asscociation
resource "aws_route_table_association" "app1-a" {
  subnet_id      = aws_subnet.app1.id
  route_table_id = aws_route_table.petclinic-pub-rt.id
}

#app2 subnet asscociation
resource "aws_route_table_association" "app2-a" {
  subnet_id      = aws_subnet.app2.id
  route_table_id = aws_route_table.petclinic-pub-rt.id
}

#app3 subnet asscociation
resource "aws_route_table_association" "app3-a" {
  subnet_id      = aws_subnet.app3.id
  route_table_id = aws_route_table.petclinic-pub-rt.id
}




# THIS SECTION IS COMMENTED FOR THE PURPOSE OF COST AND CURRENT PROJECT NEED
# PRIVATE SUBNET ROUTE TABLE (with NAT Gateway for internet access)
/*
resource "aws_route_table" "petclinic-priv-rt" {
  vpc_id = aws_vpc.petclinic.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.petclinic-nat.id
  }

  tags = {
    Name = "petclinic-priv-rt"
  }
}

resource "aws_route_table_association" "priv1-a" {
  subnet_id      = aws_subnet.priv1.id
  route_table_id = aws_route_table.petclinic-priv-rt.id
}

resource "aws_route_table_association" "priv2-a" {
  subnet_id      = aws_subnet.priv2.id
  route_table_id = aws_route_table.petclinic-priv-rt.id
}

resource "aws_route_table_association" "priv3-a" {
  subnet_id      = aws_subnet.priv3.id
  route_table_id = aws_route_table.petclinic-priv-rt.id
}

# NAT GATEWAY
resource "aws_nat_gateway" "petclinic-nat" {
  allocation_id = aws_eip.petclinic-nat.id
  subnet_id     = aws_subnet.app1.id
  tags = {
    Name = "petclinic-nat"
  }
}

# EIP for NAT Gateway
resource "aws_eip" "petclinic-nat" {
  vpc = true
}
*/