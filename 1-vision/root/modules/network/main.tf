resource "aws_vpc" "mainvpc" {
  cidr_block = var.cidr_vpc

  #required for eks
  enable_dns_hostnames = true
  enable_dns_support = true
  #for the vpc
  enable_classiclink = false
  enable_classiclink_dns_support = false
  #dont need ipv6
  assign_generated_ipv6_cidr_block = false
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.mainvpc.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}
output "vpc_id" {
  value = aws_vpc.mainvpc.id
  description = "VPC id:"
  sensitive = false
}