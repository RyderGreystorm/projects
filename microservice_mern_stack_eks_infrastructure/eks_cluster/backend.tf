provider "aws" {
  region  = var.REGION
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "Hashicorp/aws"
      version = "~> 5.80.0"
    }
  }
  backend "s3" {
    bucket         = "projectx-state-mgt-biekro111"
    key            = "global/mystatefiles/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}