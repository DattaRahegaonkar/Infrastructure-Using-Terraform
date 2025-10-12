
# --------------------------- Create a VPC ---------------------------

resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "vpc-${var.env}"
        Environment = var.env
        Terraform   = "true"
    }
}

# --------------------------- Create Subnets ---------------------------

# public subnets for eu-west-1a, eu-west-1b

resource "aws_subnet" "public_subnet_1a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true

    availability_zone = "eu-west-1a" 

    tags = {
        Name = "public-subnet-1a-${var.env}"
        Environment = var.env
        "kubernetes.io/role/elb"                 = "1"
        "kubernetes.io/cluster/ecommerce-eks-cluster" = "shared"
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
        "kubernetes.io/role/elb" = "1"
        "kubernetes.io/cluster/ecommerce-eks-cluster" = "shared"
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
        "kubernetes.io/role/internal-elb"        = "1"
        "kubernetes.io/cluster/ecommerce-eks-cluster" = "shared"
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
        "kubernetes.io/role/internal-elb"        = "1"
        "kubernetes.io/cluster/ecommerce-eks-cluster" = "shared"
    }
}


# --------------------------- Internet Gateway ---------------------------

resource "aws_internet_gateway" "internet_gateway" {

    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "internet_gateway_${var.env}"
        Environment = var.env
    }

}

# --------------------------- Nat Gateway ---------------------------

resource "aws_eip" "nat_eip_1a" {

    domain = "vpc"

    tags = {
        Name = "nat_eip_1a_${var.env}"
        Environment = var.env
    }
}

resource "aws_eip" "nat_eip_1b" {

    domain = "vpc"

    tags = {
        Name = "nat_eip_1b_${var.env}"
        Environment = var.env
    }
}

resource "aws_nat_gateway" "nat_gateway_1a" {

    allocation_id = aws_eip.nat_eip_1a.id

    subnet_id = aws_subnet.public_subnet_1a.id

    tags = {
        Name = "nat_gateway_1a_${var.env}"
        Environment = var.env
    }

}

resource "aws_nat_gateway" "nat_gateway_1b" {

    allocation_id = aws_eip.nat_eip_1b.id

    subnet_id = aws_subnet.public_subnet_1b.id

    tags = {
        Name = "nat_gateway_1b_${var.env}"
        Environment = var.env
    }

}

# --------------------------- Route Tables ---------------------------

# public route table creation

resource "aws_route_table" "public_route_table" {

    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
        Name = "public_route_table_${var.env}"
        Environment = var.env
    }

}

resource "aws_route_table_association" "public_route_table_association_1a" {

    subnet_id = aws_subnet.public_subnet_1a.id
    route_table_id = aws_route_table.public_route_table.id

}

resource "aws_route_table_association" "public_route_table_association_1b" {

    subnet_id = aws_subnet.public_subnet_1b.id
    route_table_id = aws_route_table.public_route_table.id

}

# private route table creation


resource "aws_route_table" "private_route_table_1a" {

    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway_1a.id
    }

    tags = {
        Name = "private_route_table_1a_${var.env}"
        Environment = var.env
    }

}

resource "aws_route_table" "private_route_table_1b" {

    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway_1b.id
    }

    tags = {
        Name = "private_route_table_1b_${var.env}"
        Environment = var.env
    }

}

resource "aws_route_table_association" "private_route_table_association_1a" {

    subnet_id = aws_subnet.private_subnet_1a.id
    route_table_id = aws_route_table.private_route_table_1a.id

}

resource "aws_route_table_association" "private_route_table_association_1b" {

    subnet_id = aws_subnet.private_subnet_1b.id
    route_table_id = aws_route_table.private_route_table_1b.id

}
