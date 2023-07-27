#vpc,s3-tfstate
terraform {
  required_version = ">=1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.57.1"
    }
  }
  backend "s3" {
    bucket = "1vision-root-remote-state"
    key    = "root-terraform/remote-state"
    region = "us-east-1"
  }
}
provider "aws" {
  region = "us-east-1"
}
module "amplify-1-recipe" {
  source              = "./modules/amplify/"
  amplify-repositorie = "https://github.com/1-vision/1-recipe-frontend"
  amplify-name        = "1-recipe"
  amplify-git-secret  = var.git-secret
}
module "vpc" {
  source = "./modules/network/"
}
module "ecr" {
  source    = "./modules/ecr/"
  repo-name = "1-vision"
}
