
variable "ec2_instance_type" {
  description = "The type of EC2 instance to use for the application server."
  default     = "t2.micro"
  type        = string
}

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
