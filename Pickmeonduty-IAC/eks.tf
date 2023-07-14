resource "aws_eks_cluster" "eks-cluster" {
  name                 = "pickme_onduty-cluster"
  role_arn             = aws_iam_role.eks-iam-role-cluster.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    security_group_ids = [aws_security_group.pickme_onduty-cluster-sg.id]
    subnet_ids         = flatten(["${aws_subnet.private1.id}", "${aws_subnet.private4.id}"])
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  version              = "1.27"

  depends_on = [
    aws_iam_role.eks-iam-role-cluster,
  ]

  tags = {
    "alpha.eksctl.io/cluster-oidc-enabled" = "true"
  }
}

resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.eks-cluster.name
  node_group_name = "pickme_onduty-workernodes"
  node_role_arn  = aws_iam_role.workernodes.arn
  subnet_ids   = flatten(["${aws_subnet.private1.id}","${aws_subnet.private4.id}"])
  instance_types = ["t2.small"]
 
  scaling_config {
   desired_size = 2
   max_size   = 5
   min_size   = 2
  }
 
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   #aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
 }





