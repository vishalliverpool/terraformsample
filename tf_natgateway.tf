resource "aws_eip" "nat-gateway-eip" {
  depends_on = [
    aws_route_table.my_vpc_us_east_1a_public
  ]
  vpc = true
}

# Creating a NAT Gateway!
resource "aws_nat_gateway" "nat_gateway" {
  depends_on = [
    aws_eip.nat-gateway-eip
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.nat-gateway-eip.id

  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.public.id
  tags = {
    Name = "nat-gateway-project"
  }
}

# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "nat-gateway-rt" {
  depends_on = [
    aws_nat_gateway.nat_gateway
  ]

  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

}

# Creating an Route Table Association of the NAT Gateway route
# table with the Private Subnet!
resource "aws_route_table_association" "nat-gateway-rt-assocation" {
  depends_on = [
    aws_route_table.nat-gateway-rt
  ]

#  Private Subnet ID for adding this route table to the Private subnet!
  subnet_id      = aws_subnet.prod-subnet-private-1.id

# Route Table ID
  route_table_id = aws_route_table.nat-gateway-rt.id
}
