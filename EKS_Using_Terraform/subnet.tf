
# public subnets for eu-west-1a, eu-west-1b

resource "aws_subnet" "public_subnet_1a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true

    availability_zone = "eu-west-1a" 

    tags = {
        Name = "public-subnet-1a-${var.env}"
        Environment = var.env
    }
}

resource "aws_subnet" "public_subnet_1b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true

    availability_zone = "eu-west-1b" 

    tags = {
        Name = "public-subnet-1b-${var.env}"
        Environment = var.env
    }
}


# private subnets for eu-west-1a, eu-west-1b

resource "aws_subnet" "private_subnet_1a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = false

    availability_zone = "eu-west-1a"

    tags = {
        Name = "private-subnet-1a-${var.env}"
        Environment = var.env
    }
}

resource "aws_subnet" "private_subnet_1b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = false

    availability_zone = "eu-west-1b"

    tags = {
        Name = "private-subnet-1b-${var.env}"
        Environment = var.env
    }
}