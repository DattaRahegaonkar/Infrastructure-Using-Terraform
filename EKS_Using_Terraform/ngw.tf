

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