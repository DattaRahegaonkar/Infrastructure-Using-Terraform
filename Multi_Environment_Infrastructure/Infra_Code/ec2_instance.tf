# key-pair for login

resource aws_key_pair terraform_key {
    key_name   = "${var.env}_infra_key"
    public_key = file("terraform-ec2-key.pub")

    tags = {
        Name        = "${var.env}_infra_key"
        environment = var.env
    }
}

# default VPC configuration 

resource aws_default_vpc default {
    tags = {
        Name = "Default VPC"
    }
}

# security group configuration

resource aws_security_group default_sg {

    name = "${var.env}_default_sg"
    description = "Default security group for the instance"
    vpc_id = aws_default_vpc.default.id

    tags = {
        Name = "Security Group for ${var.env} environment"
        environment = var.env
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

    count = var.instance_count

    depends_on = [aws_key_pair.terraform_key, aws_security_group.default_sg, aws_default_vpc.default]

    key_name = aws_key_pair.terraform_key.key_name
    vpc_security_group_ids = [aws_security_group.default_sg.id]
    ami = var.ec2_ami_id
    instance_type = var.instance_type

    user_data = file("install.sh")


    # configure a storage
    
    root_block_device {
        volume_size = var.env == "prod" ? 10 : 8  

        volume_type = "gp3"
        delete_on_termination = true
    }

    volume_tags = {
        Name = "Terraform EC2 Volume"
        environment = var.env
    }

    tags = {
        Name = "${var.env}_terraform_ec2_instance"
        environment = var.env
    }
}
