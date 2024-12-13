#REGIONS AND AZs
variable "REGION" {
  default = "us-east-1"
}

#VPC VARS
variable "vpc_cidr" {
  description = "describes the cidr range of the vpc"
}

variable "priv-sub-cdir-block" {
  description = "cidr blocks for private subnets"
  type        = list(string)
}


variable "pub-sub-cdir-block" {
  description = "cidr blocks for private subnets"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "kubernetes version"
}

variable "aws_availability_zones" {
  description = "cidr blocks for private subnets"
  type        = list(string)
}

variable "cluster-sg-name" {
  description = "describes the cidr range of the vpc"
}

#VERSIONS
variable "terraform_required_version" {
  type    = string
  default = ">= 1.0"
}

variable "aws_version" {
  type    = string
  default = "~> 5.80.0"
}

#IAM AND CLUSTER
variable "is_eks_role_enabled" {
  description = "check if we are using module's default iam configuration for the eks cluster"
  type        = bool
}

variable "is_eks_cluster_enabled" {
  description = "check if we are using module's default iam configuration for the eks cluster"
  type        = bool
}

variable "cluster_version" {
  description = "k8s cluster version in eks"
  type        = string
}

variable "endpoint_private_access" {
  description = "k8s cluster version in eks"
  type        = string
}

variable "endpoint_public_access" {
  description = "k8s cluster version in eks"
  type        = string
}

variable "desired_capacity" {
  description = "desired number of nodes"
  type        = string
}

variable "mini_capacity" {
  description = "desired number of nodes"
  type        = string
}

variable "max_capacity" {
  description = "desired number of nodes"
  type        = string
}

variable "max_unavailable" {
  description = "Update outtage capacity"
  type        = string
}

variable "spot_desired_capacity" {
  description = "desired number of nodes"
  type        = string
}

variable "spot_mini_capacity" {
  description = "desired number of nodes"
  type        = string
}

variable "spot_max_capacity" {
  description = "desired number of nodes"
  type        = string
}

variable "spot_max_unavailable" {
  description = "Update outtage capacity"
  type        = string
}

variable "ondemand_instance_type" {
  description = "Instance type for our ondemand vms"
  type        = list(string)
}
variable "spot_instance_types" {
  description = "Instance types for our spot instances"
  type        = list(string)
}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))
}