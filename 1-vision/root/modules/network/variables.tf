variable "cidr_vpc"{
  type = string
  description = "simple cidr, default is 10.0.0.0/16"
  default = "10.0.0.0/16"
}
variable "cidr_private_subnet_1a" {
  type = string
  description = "subnet cidr, default is 10.0.0.0/18"
}
variable "cidr_private_subnet_1b" {
  type = string
  description = "subnet cidr, default is 10.0.64.0/18"
}
variable "cidr_public_subnet_1a" {
  type = string
  description = "subnet cidr, default is 10.0.128.0/18"
}
variable "cidr_public_subnet_1b" {
  type = string
  description = "subnet cidr, default is 10.0.192.0/18"
}