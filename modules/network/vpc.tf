resource "aws_vpc" "mainvpc" {
  cidr_block = var.cidr-vpc

  #required for eks
  enable_dns_hostnames = true
  enable_dns_support = true
  #for the vpc
  #enable_classiclink = false
  #enable_classiclink_dns_support = false
  #dont need ipv6
  #assign_generated_ipv6_cidr_block = false
  tags = {
    Department  = "DevOps" 
    Environment = "Production" 
    Name   = "root-vpc" 
    Owner       = "Terraform" 
    Project     = "1-vision-root-terraform" 
  }
}
output "vpc_id" {
  value = aws_vpc.mainvpc.id
  description = "VPC id:"
  sensitive = false
}