resource "aws_route_table" "public"{
  vpc_id = aws_vpc.mainvpc.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
  tags = {
    Name = "public-route-table"
  }
}
resource "aws_route_table" "private-1"{
  vpc_id = aws_vpc.mainvpc.id
  route{
    cidr_block = "0.0.0.0/0"
    nat_gateway_id= aws_nat_gateway.gw1.id
  }
  tags = {
    Name = "private-route-table-1"
    NAT-Gateway = "GW1"
  }
}
resource "aws_route_table" "private-2"{
  vpc_id = aws_vpc.mainvpc.id
  route{
    cidr_block = "0.0.0.0/0"
    nat_gateway_id= aws_nat_gateway.gw2.id
  }
  tags = {
    Name = "private-route-table-2"
    NAT-Gateway = "GW2"
  }
}
