terraform {
  backend "s3" {
    bucket  = "multi-biekro"
    key     = "terraform/aws/terraform.tfstate"
    region  = "us-east-1"
    profile = "terradmin"
  }
}

