
variable "ec2_ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  default     = "ami-01f23391a59163da9" # Ubuntu AMI image ID
  type        = string
}
variable "root_volume_size" {
  description = "The size of the root volume in GB."
  default     = 8
  type        = number
}

variable root_volume_type {
  description = "The type of the root volume."
  default     = "gp3"
  type        = string
}

variable "env" {
  description = "The environment for the EC2 instances (e.g., dev, staging, prod)."
  default     = "dev"
  type        = string
}