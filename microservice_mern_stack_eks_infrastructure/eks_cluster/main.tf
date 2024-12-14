module "esk" {
  source = "../modules"

  #Project required
  spot_max_capacity = var.spot_max_capacity
  pub-sub-cdir-block = var.pub-sub-cdir-block
  spot_instance_types = var.spot_instance_types
  ondemand_instance_type = var.ondemand_instance_type
  addons = var.addons
  is_eks_role_enabled = var.is_eks_role_enabled
  endpoint_public_access = var.endpoint_public_access
  max_capacity = var.max_capacity
  spot_desired_capacity = var.spot_desired_capacity
  vpc_cidr = var.vpc_cidr
  is_eks_cluster_enabled = var.is_eks_cluster_enabled
  mini_capacity = var.mini_capacity
  desired_capacity = var.desired_capacity
  cluster-sg-name = var.cluster-sg-name
  spot_max_unavailable = var.spot_max_unavailable
  kubernetes_version = var.kubernetes_version
  spot_mini_capacity = var.spot_mini_capacity
  cluster_version = var.cluster_version
  endpoint_private_access = var.endpoint_private_access
  aws_availability_zones = var.aws_availability_zones
  max_unavailable = var.max_unavailable
  priv-sub-cdir-block = var.priv-sub-cdir-block
}