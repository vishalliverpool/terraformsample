resource "aws_subnet" "prod-subnet-private-1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.cidrblock["private"]
    availability_zone = "us-east-1b"
    tags = {
        Name = "private-subnet"
    }
}