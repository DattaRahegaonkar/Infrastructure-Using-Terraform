# Infrastructure-Using-Terraform

This repository contains Terraform configurations for creating AWS infrastructure across different scenarios and environments.

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed (version >= 1.0)
- SSH key pair for EC2 access (where required)

## Common Deployment Steps

1. **Navigate to desired directory:**
   ```bash
   cd <directory_name>/
   ```

2. **Generate SSH key pair (if required for EC2):**
   ```bash
   ssh-keygen -t rsa -b 2048 -f terraform-ec2-key
   ```

3. **Initialize Terraform:**
   ```bash
   terraform init
   ```

4. **Review the plan:**
   ```bash
   terraform plan
   ```

5. **Apply the configuration:**
   ```bash
   terraform apply
   OR
   terraform apply --auto-approve
   ```

6. **Destroy resources when done:**
   ```bash
   terraform destroy
   OR
   terraform destroy --auto-approve
   ```
this is terraform readme.md
