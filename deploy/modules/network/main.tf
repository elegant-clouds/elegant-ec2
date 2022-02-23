data "http" "admin-ip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_vpc" "node01_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "terraformer"
  }
}

resource "aws_internet_gateway" "node01_gw" {
  vpc_id = aws_vpc.node01_vpc.id
}

resource "aws_subnet" "node01_subnet" {
  vpc_id            = aws_vpc.node01_vpc.id
  cidr_block        = "172.16.16.0/24"
  availability_zone = var.a_zone
}

resource "aws_route_table" "node01_rt" {
  vpc_id = aws_vpc.node01_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.node01_gw.id
  }
}

resource "aws_route_table_association" "node01_rt_asc" {
  subnet_id      = aws_subnet.node01_subnet.id
  route_table_id = aws_route_table.node01_rt.id
}

resource "aws_security_group" "node01_sg" {
  name        = "node01_security_group"
  description = "Allow HTTP HTTPS IMCP inbound and ALL outbound"
  vpc_id      = aws_vpc.node01_vpc.id

  ingress {
    description = "Allow HTTPS (TLS) inbound"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP inbound"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH inbound"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.admin-ip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
