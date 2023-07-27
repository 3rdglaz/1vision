resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.mainvpc.id

  tags = {
    Name = "mainvpc-internet-gateway"
    Ownerd = "Terraform"
  }
}