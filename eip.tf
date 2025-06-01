# Elastic IP for NAT gateway
resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.IGW]
  domain = "vpc"
  tags = {
    Name = "EIP_for_NAT"
  }
}

# A NAT gateway for private subnets: For ec2 instances softwares updates)
resource "aws_nat_gateway" "nat_for_private_subnet" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet_1.id 

  tags = {
    Name = "NAT for private subnet"
  }

  depends_on = [aws_internet_gateway.IGW]
}

# route table - connecting to NAT
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_for_private_subnet.id
  }
}

# associate the route table with private subnet
resource "aws_route_table_association" "rta3" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.rt_private.id
}