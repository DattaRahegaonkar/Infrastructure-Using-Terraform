

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

locals {
    cluster_name = "eks-cluster-${random_string.suffix.result}"
    vpc_cidr = "10.0.0.0/16"
    env = "dev"
    azs             = ["eu-west-1a", "eu-west-1b"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
}

