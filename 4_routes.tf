# Create a custom route table for public subnet
resource "aws_route_table" "prod-public-crt" {
  vpc_id = aws_vpc.nginx-vpc.id
  route {
    cidr_block = "0.0.0.0/0"                      //associated subnet can reach everywhere
    gateway_id = aws_internet_gateway.prod-igw.id //CRT uses this IGW to reach internet
  }
  tags = {
    Name = "prod-public-crt"
  }
}
# Route table association for the public subnet
resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  subnet_id      = aws_subnet.prod-subnet-public-1.id
  route_table_id = aws_route_table.prod-public-crt.id
}

# Create a custom route table for private subnet
resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.nginx-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"            //associated subnet can reach everywhere
    nat_gateway_id = aws_nat_gateway.ngw.id //CRT uses this IGW to reach internet
  }
  tags = {
    Name = "priv-route"
  }
}


# Route table association for the private subnet
resource "aws_route_table_association" "rta-private-subnet-2" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route.id
}