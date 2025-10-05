

resource "aws_eip" "nat_eip" {

    domain = "vpc"

    tags = {
        Name = "nat_eip_${var.env}"
        Environment = var.env
    }
}


resource "aws_nat_gateway" "nat_gateway" {

    allocation_id = aws_eip.nat_eip.id

    subnet_id = aws_subnet.public_subnet.id

    tags = {
        Name = "nat_gateway_${var.env}"
        Environment = var.env
    }

}