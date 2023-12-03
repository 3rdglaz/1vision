resource "aws_subnet" "private-subnet-1a" {
  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = var.cidr_private_subnet_1a
  availability_zone = "us-east-1a"

  tags = {
    "Name"                                      = "private-us-east-1a"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"#"owned"
  }
}

resource "aws_subnet" "private-subnet-1b" {
  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = var.cidr_private_subnet_1b
  availability_zone = "us-east-1b"

  tags = {
    "Name"                                      = "private-us-east-1b"
    "kubernetes.io/role/internal-elb"           = "1" #sem aspas?
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"#"owned"
  }
}

resource "aws_subnet" "public-subnet-1a" {
  vpc_id                  = aws_vpc.mainvpc.id
  cidr_block              = var.cidr_public_subnet_1a
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-us-east-1a"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public-subnet-1b" {
  vpc_id                  = aws_vpc.mainvpc.id
  cidr_block              = var.cidr_public_subnet_1b
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-us-east-1b"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}