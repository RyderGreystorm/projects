terraform {
  backend "s3" {
    bucket  = "multi-biekro"
    key     = "terraform/backend"
    region  = "us-east-1"
    profile = "terradmin"
  }
}