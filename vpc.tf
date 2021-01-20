resource "aws_vpc" "my_vpc" {
  cidr_block       = var.cidrblock_vpc
  enable_dns_hostnames = true
  enable_dns_support = "true" #gives you an internal domain name
  enable_classiclink = "false"
  instance_tenancy = "default"

  tags = {
    Name = "My VPC"
  }
}