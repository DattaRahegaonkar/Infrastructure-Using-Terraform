
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "private_subnet_1_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_2_cidr" {
  default = "10.0.2.0/24"
}

variable "az_public_subnet" {
  default = "eu-west-1a"
}

variable "az1_private_subnet" {
  default = "eu-west-1b"
}

variable "az2_private_subnet" {
  default = "eu-west-1c"
}

variable "project_name" {
  default = "3-tier"
}