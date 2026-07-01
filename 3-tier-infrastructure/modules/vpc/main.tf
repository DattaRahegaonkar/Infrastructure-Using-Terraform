
resource "aws_vpc" "tf-vpc" {

  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_subnet" "tf-public-subnet" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone       = var.az_public_subnet

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

resource "aws_subnet" "tf-private-subnet-1" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = var.private_subnet_1_cidr
  availability_zone       = var.az1_private_subnet

  tags = {
    Name = "${var.project_name}-private-subnet-1"
  }
}

resource "aws_subnet" "tf-private-subnet-2" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = var.private_subnet_2_cidr
  availability_zone       = var.az2_private_subnet

  tags = {
    Name = "${var.project_name}-private-subnet-2"
  }
}

resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_default_route_table" "tf-main-rt" {
  default_route_table_id = aws_vpc.tf-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-igw.id
  }

  tags = {
    Name = "${var.project_name}-main-rt"
  }
}

resource "aws_route_table_association" "tf-public-subnet-association" {
  subnet_id      = aws_subnet.tf-public-subnet.id
  route_table_id = aws_default_route_table.tf-main-rt.id
}


resource "aws_eip" "tf-eip" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-eip"
  }
}

resource "aws_nat_gateway" "tf-nat" {
  allocation_id = aws_eip.tf-eip.id
  subnet_id     = aws_subnet.tf-public-subnet.id

  tags = {
    Name = "${var.project_name}-nat"
  }

  depends_on = [aws_internet_gateway.tf-igw]
}

resource "aws_route_table" "tf-private-rt" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf-nat.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

resource "aws_route_table_association" "tf-private-subnet-1-association" {
  subnet_id      = aws_subnet.tf-private-subnet-1.id
  route_table_id = aws_route_table.tf-private-rt.id
}

resource "aws_route_table_association" "tf-private-subnet-2-association" {
  subnet_id      = aws_subnet.tf-private-subnet-2.id
  route_table_id = aws_route_table.tf-private-rt.id
}


