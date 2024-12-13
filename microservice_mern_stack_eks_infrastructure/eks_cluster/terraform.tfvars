#VPC VARIABLES
vpc_cidr               = "10.16.0.0/16"
priv-sub-cdir-block    = ["10.16.0.0/20", "10.16.16.0/20", "10.16.32.0/20"]
pub-sub-cdir-block     = ["10.16.128.0/20", "10.16.144.0/20", "10.16.160.0/20"]
kubernetes_version     = 1.31
aws_availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
cluster-sg-name        = "projectX-cluster-sg"

#PROVIDER RESOURCES
REGION                     = "us-east-1"
terraform_required_version = ">= 1.0"
aws_version                = "~> 5.16.0"

#IAM AND EKS
is_eks_role_enabled     = true
is_eks_cluster_enabled  = true
cluster_version         = 1.31
endpoint_private_access = true
endpoint_public_access  = false
max_capacity            = 2
mini_capacity           = 1
desired_capacity        = 1
max_unavailable         = 1
spot_max_capacity       = 8
spot_mini_capacity      = 1
spot_desired_capacity   = 3
spot_max_unavailable    = 1
spot_instance_types = [
  "c5a.large",
  "c5a.xlarge",
  "m5a.large",
  "m5a.xlarge",
  "c5.large",
  "m5.large",
  "t3a.large",
  "t3a.xlarge",
  "t3a.medium"
]
ondemand_instance_type = ["t3.medium"]
addons = [
  {
    name    = "vpc-cni"
    version = "v1.19.0-eksbuild.1"
  },
  {
    name    = "coredns"
    version = "v1.11.3-eksbuild.2"
  },
  {
    name    = "kube-proxy"
    version = "v1.31.2-eksbuild.3"
  },
  {
    name    = "aws-ebs-csi-driver"
    version = "v1.37.0-eksbuild.1"
  }
]