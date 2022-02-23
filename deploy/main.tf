terraform {
  cloud {
    organization = "elegantclouds"
    workspaces {
      name = "elegant-ec2"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2.0"
    }
  }
  required_version = "~> 1.1.6"
}

# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# -------------- Modules --------------
module "network" {
  source = "./modules/network"
  a_zone = var.a_zone
}

module "ec2" {
  source           = "./modules/ec2"
  ami_type         = var.ami_type
  ami_os           = var.ami_os
  ssh_key_name     = var.ssh_key_name
  pub_key          = var.pub_key
  node01_sg_id     = module.network.node01_sg_id
  node01_subnet_id = module.network.node01_subnet_id
}