
# Terraform Variables

Terraform variables are declared in a `variables.tf` file and can be assigned values using different methods.

## 1. Declare Variables

```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
```

## 2. Assign Variable Values

### Using Command Line

```
terraform apply -var instance_type=t2.micro
```

### Using `.auto.tfvars`

Terraform automatically loads files ending with `.auto.tfvars`.

Example: `variable.auto.tfvars`

```
instance_type = "t2.micro"
```

### Using `terraform.tfvars`

```hcl
instance_type = "t2.micro"
ami_id        = "ami-12345678"
```

### Using Environment Variables

```bash
export TF_VAR_instance_type="t2.micro"
export TF_VAR_ami_id="ami-12345678"
```

Terraform automatically maps:

```text
TF_VAR_instance_type → var.instance_type
```

## 3. Use Variables

```hcl
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
}
```

## Variable Priority Order (Highest to Lowest)

Terraform resolves variable values in the following order:

1. **Command-line **

2. **`*.auto.tfvars`**** **

3. **`terraform.tfvars`**

4. **Environment Variables**

5. **Default Values in Variable Blocks**

If the same variable is defined in multiple places, Terraform uses the value from the highest-priority source.
