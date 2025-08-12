
module "eks" {
    # import modules from Terraform AWS EKS module
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 21.0"

    # EKS cluster information ( Control Plane )
    name = local.cluster_name
    kubernetes_version = "1.31"

    endpoint_public_access            = true
    endpoint_private_access          = true
    enable_cluster_creator_admin_permissions = true

    vpc_id     = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets

    # Control Plane Network
    control_plane_subnet_ids = module.vpc.private_subnets

    # EKS managed node groups
    eks_managed_node_groups = {

        eks_cluster_nodes = {
            instance_types = ["t2.medium"]
            create_iam_role = true
            attach_cluster_primary_security_group = true

            min_size     = 1
            max_size     = 1
            desired_size = 1

        }
  }

    tags = {
        Environment = "dev"
        Terraform   = "true"
    }
}