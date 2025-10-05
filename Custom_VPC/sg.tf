
resource "aws_security_group" "public_subnet_sg" {

    description = "Allow HTTP, HTTPS, SSH access for public subnet"

    vpc_id = aws_vpc.vpc.id


    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "public-subnet-sg-${var.env}"
        Environment = var.env
    }
}




resource "aws_security_group" "private_subnet_sg" {

  description = "Allow HTTP, HTTPS, SSH access for private subnet"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = 8081
    to_port         = 8081
    protocol        = "tcp"
    security_groups = [aws_security_group.public_subnet_sg.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_subnet_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-subnet-sg-${var.env}"
    Environment = var.env
  }
}

