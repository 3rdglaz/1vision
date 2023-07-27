resource "aws_route_table_association" "public-1" {
  subnet_id = aws_subnet.public-subnet-1a.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public-2" {
  subnet_id = aws_subnet.public-subnet-1b.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private-1" {
  subnet_id = aws_subnet.private-subnet-1a.id
  route_table_id = aws_route_table.private-1.id
}
resource "aws_route_table_association" "private-2" {
  subnet_id = aws_subnet.private-subnet-1b.id
  route_table_id = aws_route_table.private-2.id
}
