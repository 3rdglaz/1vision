resource "aws_nat_gateway" "gw1" {
  allocation_id = aws_eip.nat1.id
  subnet_id = aws_subnet.public-subnet-1a.id
  tags = {
    Name = "gw1-nat1"
    NAT = "Nat-1"
    Subnet = "public-1a"
  }
}
resource "aws_nat_gateway" "gw2" {
  allocation_id = aws_eip.nat2.id
  subnet_id = aws_subnet.public-subnet-1b.id
  tags = {
    Name = "gw2-nat2"
    NAT = "Nat-2"
    Subnet = "public-1b"
  }
}
