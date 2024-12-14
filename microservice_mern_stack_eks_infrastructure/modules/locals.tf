locals {
  cluster_name = "projectX-eks"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}