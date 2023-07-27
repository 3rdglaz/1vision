resource "aws_eip" "nat1"{
  depends_on= [aws_internet_gateway.internet-gateway]
  tags = {
    Name = "nat1"
    Subnet = "public-subnet-1a"   
  }
}

resource "aws_eip" "nat2"{
  depends_on= [aws_internet_gateway.internet-gateway]
  tags = {
    Name = "nat2"
    Subnet = "public-subnet-1b"   
  }
}
