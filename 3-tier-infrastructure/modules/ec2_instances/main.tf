
resource "aws_security_group" "tf-web-sg" {
  name        = "${var.project_name}-web-sg"
  vpc_id      = var.vpc_id

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
  vpc_id      = var.vpc_id

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
  
  key_name   = "terra-key"
  public_key = file("${path.root}/terra-key.pub")

}

resource "aws_instance" "tf-web-server" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.tf-key.key_name
  subnet_id = var.public_subnet
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
  subnet_id = var.private_subnet_1
  vpc_security_group_ids = [aws_security_group.tf-app-sg.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-app-server"
  }

}

resource "aws_instance" "tf-db-server" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.tf-key.key_name
  subnet_id = var.private_subnet_2
  vpc_security_group_ids = [aws_security_group.tf-app-sg.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-db-server"
  }

}