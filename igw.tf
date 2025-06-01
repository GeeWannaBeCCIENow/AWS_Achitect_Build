resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "InetGW"
  }
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "pub_rt_table"
  }
}

resource "aws_route" route {
  route_table_id = aws_route_table.public_RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IGW.id
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "public_association_Subnet2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_RT.id
}
