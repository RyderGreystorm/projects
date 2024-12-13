#CREATE THE CLUSTER CONTROL PLANE
resource "aws_eks_cluster" "eks" {
  count    = var.is_eks_cluster_enabled ? 1 : 0
  name     = local.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks-cluster-role[count.index].arn


  vpc_config {
    subnet_ids              = [aws_subnet.private-subnet[0].id, aws_subnet.private-subnet[1].id, aws_subnet.private-subnet[2].id]
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = {
    Name = "${local.cluster_name}-control-plane"
 
  }
  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  ]
}

#EKS NODE GROUP ADD-ONS
resource "aws_eks_addon" "eks-addons" {
  for_each      = { for i, addon in var.addons : i => addon }
  cluster_name  = aws_eks_cluster.eks[0].name
  addon_name    = each.value.name
  addon_version = each.value.version

  depends_on = [
    aws_eks_node_group.ondemand-node,
    aws_eks_node_group.spot-node
  ]
}

#EKS NODE GROUP
resource "aws_eks_node_group" "ondemand-node" {
  cluster_name    = aws_eks_cluster.eks[0].name
  node_group_name = "${local.cluster_name}-On-Demand-Node"
  node_role_arn   = aws_iam_role.node-group-role[0].arn
  version         = var.cluster_version
  subnet_ids      = aws_subnet.private-subnet[*].id

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.mini_capacity
  }

  instance_types = var.ondemand_instance_type
  capacity_type  = "ON_DEMAND"
  labels = {
    type = "ondemand"
  }
  update_config {
    max_unavailable = var.max_unavailable
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.eks
  ]

  tags = {
    "Name"                   = "${local.cluster_name}-ondemand-instance"
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }
  disk_size = 40
}


#SPOT INSTANCES
resource "aws_eks_node_group" "spot-node" {
  cluster_name    = aws_eks_cluster.eks[0].name
  node_group_name = "${local.cluster_name}-spot-nodes"

  node_role_arn = aws_iam_role.node-group-role[0].arn

  scaling_config {
    desired_size = var.spot_desired_capacity
    min_size     = var.spot_mini_capacity
    max_size     = var.spot_max_capacity
  }


  subnet_ids = [aws_subnet.private-subnet[0].id, aws_subnet.private-subnet[1].id, aws_subnet.private-subnet[2].id]

  instance_types = var.spot_instance_types
  capacity_type  = "SPOT"

  update_config {
    max_unavailable = var.spot_max_unavailable
  }
  tags = {
    "Name"                   = "${local.cluster_name}-ondemand-instance"
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }

  labels = {
    type      = "spot"
    lifecycle = "spot"
  }
  disk_size = 50

  depends_on = [aws_eks_cluster.eks]
}