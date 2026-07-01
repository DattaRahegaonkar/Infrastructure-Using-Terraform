
variable "vpc_id" {}

variable "public_subnet" {}

variable "private_subnet_1" {}

variable "private_subnet_2" {}

variable "ami" {
    default = "ami-06468be052a4195a6"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "project_name" {
    default = "3-tier"
}
