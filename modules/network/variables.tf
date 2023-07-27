variable "cidr-vpc" {
  type        = string
  description = "simple cidr, default is 10.0.0.0/16"
  default     = "10.0.0.0/16"
}
variable "instance_tags" {
  type = map(string)
  default = {
    Name        = "root-vpc"
    Project     = "1-vision-root-terraform"
    Environment = "Production"
    Owner       = "Terraform"
    Department  = "DevOps"
  }
}

variable "cidr-private-subnet-1a" {
  type = string
  description = "subnet cidr, default is 10.0.0.0/18"
  default = "10.0.0.0/18"
}
variable "cidr-private-subnet-1b" {
  type = string
  description = "subnet cidr, default is 10.0.64.0/18"
  default = "10.0.64.0/18"
}
variable "cidr-public-subnet-1a" {
  type = string
  description = "subnet cidr, default is 10.0.128.0/18"
  default = "10.0.128.0/18"
}
variable "cidr-public-subnet-1b" {
  type = string
  description = "subnet cidr, default is 10.0.192.0/18"
  default = "10.0.192.0/18"
}
variable "cluster-name" {
  type = string
  description = "random cluster name"
  default = "1-recipes-cluster"
}
variable "cluster_version"{
  type = string
  description = "cluster version for deploy, current 1.27"
  default = "1.27"
}
