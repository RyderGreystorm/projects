

resource "aws_security_group" "petclinic-sg" {
  name        = "petclinic-sg"
  description = "Stateful firewall configuration"
  vpc_id      = aws_vpc.petclinic.id

  tags = {
    Name = "petclinic-sg"
  }
}

# Ingress Rule for IPv4 (Allow TCP traffic on port 8080 from the VPC CIDR block)
resource "aws_security_group_rule" "allow_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [var.MY_IP]
  security_group_id = aws_security_group.petclinic-sg.id
}

# Ingress Rule for IPv4 (Allow TCP traffic on port 8080 from the VPC CIDR block)
resource "aws_security_group_rule" "allow_http_ipv4" {
  type        = "ingress"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.petclinic-sg.id
}


# Egress Rule for IPv4 (Allow all outbound traffic to any destination)
resource "aws_security_group_rule" "allow_all_traffic_ipv4" {
  type             = "egress"
  from_port = 0
  to_port = 0
  cidr_blocks      = ["0.0.0.0/0"]
  protocol         = "-1"  # Allow all protocols
  security_group_id = aws_security_group.petclinic-sg.id
}

# Egress Rule for IPv6 (Allow all outbound traffic to any destination)
resource "aws_security_group_rule" "allow_all_traffic_ipv6" {
  type             = "egress"
  from_port = 0
  to_port = 0
  ipv6_cidr_blocks = ["::/0"]
  protocol         = "-1"  # Allow all protocols
  security_group_id = aws_security_group.petclinic-sg.id
}