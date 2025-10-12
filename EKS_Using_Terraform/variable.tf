# --------------------------- Variables ---------------------------

variable "env" {
  description = "Environment name (dev, staging, prod)"
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

