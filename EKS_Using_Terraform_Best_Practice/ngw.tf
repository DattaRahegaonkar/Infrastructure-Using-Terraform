

# --------------------------- Create elastic IPs and NAT Gateways ---------------------------

resource "aws_eip" "nat_eip" {

    count = 2

    domain = "vpc"

    tags = {
        Name = "nat-eip-${count.index + 1}a-${var.env}"
        Environment = var.env
    }
}

# --------------------------- Create NAT Gateways ---------------------------

resource "aws_nat_gateway" "nat_gateway" {

    count = 2

    allocation_id = aws_eip.nat_eip[count.index].id

    subnet_id = aws_subnet.public_subnet[count.index].id

    tags = {
        Name = "nat_gateway-${count.index + 1}a-${var.env}"
        Environment = var.env
    }

}
