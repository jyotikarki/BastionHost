# Public subnet
resource "aws_subnet" "prod-subnet-public-1" {
  vpc_id                  = aws_vpc.nginx-vpc.id // Referencing the id of the VPC from abouve code block
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true" // Makes this a public subnet
  availability_zone       = "us-east-1a"
  tags = {
    name = "public-subnet"
  }
}

# Private subnet
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.nginx-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
}