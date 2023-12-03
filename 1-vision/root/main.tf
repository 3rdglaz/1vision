#vpc,s3-tfstate
terraform {
  required_version = "1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.57.1"
    }
  }
  # backend "s3" {
  #   bucket = "root-remote-state"
  #   key    = "root-terraform/remote-state"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
module "amplify-1-recipe" {
  source              = "./modules/amplify"
  amplify-repositorie = "https://github.com/1-vision/1-recipe-frontend"
  amplify-name        = "1-recipe"
}

module "vpc" {
  source = "./modules/network"

}
