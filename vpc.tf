
# -----------------------
# VPC Creation
# -----------------------
resource "aws_vpc" "newvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "newvpc"
  }
}

# -----------------------
# Subnets
# -----------------------

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.newvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

# Private Subnet 1
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.newvpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "private_subnet"
  }
}

# Private Subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.newvpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2c"

  tags = {
    Name = "private_subnet_2"
  }
}

# -----------------------
# Internet Gateway
# -----------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.newvpc.id

  tags = {
    Name = "main_igw"
  }
}

# -----------------------
# Route Tables
# -----------------------

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.newvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}