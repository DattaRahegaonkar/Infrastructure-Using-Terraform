
module "remote-backend" {
  source = "./remote-backend"
}


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

resource "aws_subnet" "tf-private-subnet" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone       = var.az_private_subnet

  tags = {
    Name = "${var.project_name}-private-subnet"
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

resource "aws_security_group" "tf-web-sg" {
  name        = "${var.project_name}-web-sg"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-web-sg"
  }

}

resource "aws_security_group" "tf-app-sg" {
  name        = "${var.project_name}-app-sg"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.tf-web-sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-app-sg"
  }

}

resource "aws_key_pair" "tf-key"  {
  
  key_name   = "terraform-key"
  public_key = file("terraform-key.pub")

}

resource "aws_instance" "tf-web-server" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.tf-key.key_name
  subnet_id = aws_subnet.tf-public-subnet.id
  vpc_security_group_ids = [aws_security_group.tf-web-sg.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-web-server"
  }

}

resource "aws_instance" "tf-app-server" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.tf-key.key_name
  subnet_id = aws_subnet.tf-private-subnet.id
  vpc_security_group_ids = [aws_security_group.tf-app-sg.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-app-server"
  }

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

resource "aws_route_table_association" "tf-private-subnet-association" {
  subnet_id      = aws_subnet.tf-private-subnet.id
  route_table_id = aws_route_table.tf-private-rt.id
}

