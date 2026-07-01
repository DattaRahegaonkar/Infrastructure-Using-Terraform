
variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "project_name" {
    default = "tf"
}

variable "public_subnet_cidr" {
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    default = "10.0.1.0/24"
}

variable "az_public_subnet" {
    default = "eu-west-1a"
}

variable "az_private_subnet" {
    default = "eu-west-1b"
}

variable "ami" {
    default = "ami-06468be052a4195a6"
}

variable "instance_type" {
    default = "t3.micro"
}

