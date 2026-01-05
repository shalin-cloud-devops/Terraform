terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "tf-state-s3-bucket-ecom-app-shalin"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform_eks_state_lock"
    encrypt        = true

  }
}

provider "aws" {
  region = var.region

}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  pvt_subnet_cidrs   = var.pvt_subnet_cidrs
  pub_subnet_cidrs   = var.pub_subnet_cidrs
  cluster_name       = var.cluster_name

}

