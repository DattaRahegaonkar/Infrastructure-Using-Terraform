
resource "aws_iam_role" "eks-cluster-role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

resource "aws_eks_cluster" "ecommerce-eks-cluster" {
  name = "ecommerce-eks-cluster"

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.eks-cluster-role.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.public_subnet_1a.id,
      aws_subnet.public_subnet_1b.id,
      aws_subnet.private_subnet_1a.id,
      aws_subnet.private_subnet_1b.id
    ]

    security_group_ids = [aws_security_group.eks_cluster_sg.id]

    endpoint_private_access = true
    endpoint_public_access  = true

  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}


output "cluster_endpoint" {
  value = aws_eks_cluster.ecommerce-eks-cluster.endpoint
}


resource "aws_iam_role" "eks-node-group-role" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}


resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-group-role.name
}


resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-group-role.name
}


resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-group-role.name
}


resource "aws_eks_node_group" "ecommerce-node-group" {
  cluster_name    = aws_eks_cluster.ecommerce-eks-cluster.name
  node_group_name = "ecommerce-node-group"
  node_role_arn   = aws_iam_role.eks-node-group-role.arn

  subnet_ids = [
      aws_subnet.private_subnet_1a.id,
      aws_subnet.private_subnet_1b.id
  ]

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  instance_types = ["t3.micro"]

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}