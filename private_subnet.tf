resource "aws_subnet" "prod-subnet-private-1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.cidrblock["private_subnet"]["private"]
    availability_zone = "eu-west-2a"
    map_public_ip_on_launch = false
    tags = {
        Name = "prod-subnet-private-1"
    }
}
resource "aws_internet_gateway" "prod-igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "prod-igw"
    }
}

resource "aws_route_table" "prod-private-crt" {
    vpc_id = aws_vpc.my_vpc.id

    route {
    
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prod-igw.id
    }

    tags = {
        Name = "prod-private-crt"
    }
}
resource "aws_route_table_association" "prod-crta-private-subnet-1"{
    subnet_id = aws_subnet.prod-subnet-private-1.id
    route_table_id = aws_route_table.prod-private-crt.id
}
