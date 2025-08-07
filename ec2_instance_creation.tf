
# key-pair for login

resource aws_key_pair terraform_key {
    key_name   = "terraform_key"
    public_key = file("terraform-ec2-key.pub")
}

# default VPC configuration 

resource aws_default_vpc default {
    tags = {
        Name = "Default VPC"
    }
}

# security group configuration

resource aws_security_group default_sg {

    name = "default_sg"
    description = "Default security group for the instance"
    vpc_id = aws_default_vpc.default.id

    tags = {
        Name = "allow_tls"
    }

    # Inbound rules for the security group

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH access"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP access"
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP access on port 8080"
    }

    # Outbound rules for the security group

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
}


# EC2 instance configuration

resource aws_instance terraform_ec2_instance {
    
    key_name = aws_key_pair.terraform_key.key_name
    vpc_security_group_ids = [aws_security_group.default_sg.id]
    ami = var.ec2_ami_id
    instance_type = var.ec2_instance_type

    user_data = file("install.sh")


    # confiure a storage 
    volume_tags = {
        Name = "Terraform EC2 Volume"
    }
    
    root_block_device {
        volume_size = var.root_volume_size
        volume_type = var.root_volume_type
        delete_on_termination = true
    }

    tags = {
        Name = "Terraform EC2 Instance"
    }
}
