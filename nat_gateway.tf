resource "aws_subnet" "nat_gateway" {
  availability_zone = "us-east-1a"
  cidr_block = var.cidrblock["public_subnet"]["public"]
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    "Name" = "my nat gateway"
  }
}

resource "aws_internet_gateway" "nat_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    "Name" = "testGateway"
  }
}

resource "aws_route_table" "nat_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "nat_gateway" {
  subnet_id = aws_subnet.nat_gateway.id
  route_table_id = aws_route_table.nat_gateway.id
}


resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id = aws_subnet.nat_gateway.id
  tags = {
    "Name" = "DummyNatGateway"
  }
}

output "nat_gateway_ip" {
  value = aws_eip.nat_gateway.public_ip
}
