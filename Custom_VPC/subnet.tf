
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true

    availability_zone = "eu-west-1a" 

    tags = {
        Name = "public-subnet-${var.env}"
        Environment = var.env
    }
}


resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = false

    availability_zone = "eu-west-1a"

    tags = {
        Name = "private-subnet-${var.env}"
        Environment = var.env
    }
}