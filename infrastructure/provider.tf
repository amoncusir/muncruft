
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.31.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "3.57.0"
    }
  }

  backend "local" {
    path = "backend/terraform.tfstate"
  }
}

provider "hcloud" {
  token = var.hetzner_token
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
