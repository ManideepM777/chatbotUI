resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster-name
  role_arn = aws_iam_role.EKSClusterRole.arn
  vpc_config {
    subnet_ids         = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
    security_group_ids = [aws_security_group.security_group.id]
    endpoint_public_access = true
  }

  version = 1.30

  depends_on = [aws_iam_role_policy_attachment.AmazonEKSClusterPolicy]
}

#addons
resource "aws_eks_addon" "coredns" {
  cluster_name               = aws_eks_cluster.eks-cluster.name
  addon_name                 = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name               = aws_eks_cluster.eks-cluster.name
  addon_name                 = "kube-proxy"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name               = aws_eks_cluster.eks-cluster.name
  addon_name                 = "vpc-cni"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "eks_pod_identity_agent" {
  cluster_name               = aws_eks_cluster.eks-cluster.name
  addon_name                 = "eks-pod-identity-agent"
  resolve_conflicts_on_create = "OVERWRITE"
}
