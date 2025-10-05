# EKS Cluster Using Terraform

This directory contains Terraform configuration to create an Amazon EKS cluster with associated VPC infrastructure.

## Prerequisites

- AWS CLI configured with appropriate credentials
- kubectl installed
- Terraform >= 1.0

## Infrastructure Components

### Networking
- **VPC** with public and private subnets across 2 AZs
- **Internet Gateway** and **NAT Gateway** for connectivity
- **Route Tables** for public and private subnets
- **Security Groups** for EKS cluster

### EKS Resources
- **EKS Cluster** (version 1.31) with API authentication
- **EKS Node Group** with auto-scaling (2-4 t3.micro instances)
- **IAM Roles** and policies for cluster and worker nodes

## Deployment Steps

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Review the plan:**
   ```bash
   terraform plan
   ```

3. **Apply configuration:**
   ```bash
   terraform apply
   # OR for auto-approval
   terraform apply --auto-approve
   ```

4. **Configure kubectl:**
   ```bash
   aws eks update-kubeconfig --region eu-west-1 --name ecommerce-eks-cluster
   ```

5. **Verify cluster:**
   ```bash
   kubectl get nodes
   ```

## Troubleshooting

If you encounter access errors:
1. Go to AWS Console → EKS → Clusters → Access
2. Add your IAM user with `AmazonEKSAdminPolicy`

## Cleanup

```bash
terraform destroy --auto-approve
```