
variable "env" {
  description = "The environment for the resources (e.g., dev, stg, prod)"
  type        = string
}

variable "bucket_name" {
  description = "The bucket name the infra code"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}

variable "ec2_ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
}

variable "hash_key" {
  description = "The hash key for the DynamoDB table"
  type        = string
}

