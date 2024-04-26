# Creating an Internet Gateway
resource "aws_internet_gateway" "prod-igw" {
  vpc_id = aws_vpc.nginx-vpc.id
}

# Elastic IP
resource "aws_eip" "ep1" {
  depends_on = [aws_internet_gateway.prod-igw]
  tags = {
    Name = "nginx_ep"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ep1.id
  subnet_id     = aws_subnet.prod-subnet-public-1.id
  tags = {
    Name = "nginx_nat"
  }
}