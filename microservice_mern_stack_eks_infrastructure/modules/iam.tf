resource "random_integer" "random_suffix" {
  min = 100
  max = 9999
}

# CONTROL PLANE IAM ROLE
resource "aws_iam_role" "eks-cluster-role" {
  count = var.is_eks_role_enabled ? 1 : 0
  name  = "${local.cluster_name}-role${random_integer.random_suffix.result}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${local.cluster_name}-iam-cluster-role"
  }
}

#CONTROL PLANE IAM-ROLE ATTACHEMENT
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  count      = var.is_eks_role_enabled ? 1 : 0
  role       = aws_iam_role.eks-cluster-role[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

#NODE GROUP IAM CONFIGS
# CONTROL PLANE IAM ROLE
resource "aws_iam_role" "node-group-role" {
  count = var.is_eks_role_enabled ? 1 : 0
  name  = "${local.cluster_name}-node-role-${random_integer.random_suffix.result}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${local.cluster_name}-iam-cluster-role"
  }
}

#NODE GROUP POLICY ATTACHEMENT
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  count      = var.is_eks_role_enabled ? 1 : 0
  role       = aws_iam_role.node-group-role[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

#NODE GROUP CNI POLICY ATTACHEMENT
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  count      = var.is_eks_role_enabled ? 1 : 0
  role       = aws_iam_role.node-group-role[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

#NODE GROUP CONTAINER REGISTRY READ ONLY POLICY ATTACHEMENT
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  count      = var.is_eks_role_enabled ? 1 : 0
  role       = aws_iam_role.node-group-role[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# OIDC
resource "aws_iam_role" "eks_oidc" {
  assume_role_policy = data.aws_iam_policy_document.eks_oidc_assume_role_policy.json
  name               = "eks-oidc"
}

resource "aws_iam_policy" "eks-oidc-policy" {
  name = "projectX-policy"

  policy = jsonencode({
    Statement = [{
      Action = [
        "s3:ListAllMyBuckets",
        "s3:GetBucketLocation",
        "*"
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-oidc-policy-attach" {
  role       = aws_iam_role.eks_oidc.name
  policy_arn = aws_iam_policy.eks-oidc-policy.arn
}