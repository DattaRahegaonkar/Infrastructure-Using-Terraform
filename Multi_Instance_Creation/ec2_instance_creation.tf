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

    # count meta argument to create multiple instances with same instance name
    # count = 2

    # for_each meta argument to create multiple instances with different instance names
    for_each = tomap({
        "terraform-ec2-t2.micro" = "t2.micro",
        "terraform-ec2-t3.micro" = "t3.micro",
    })

    # This meta-argument defines that a particular resource will not be created or modified
    # until the resources it depends on are fully created or updated successfully.
    depends_on = [aws_key_pair.terraform_key, aws_security_group.default_sg, aws_default_vpc.default]

    key_name = aws_key_pair.terraform_key.key_name
    vpc_security_group_ids = [aws_security_group.default_sg.id]
    ami = var.ec2_ami_id
    instance_type = each.value

    user_data = file("install.sh")


    # configure a storage
    volume_tags = {
        Name = "Terraform EC2 Volume"
    }
    
    root_block_device {
        # Using a conditional expression(Ternary Operator) we can set the volume size based on the environment variable
        volume_size = var.environment == "prod" ? 10 : var.root_volume_size   

        volume_type = var.root_volume_type
        delete_on_termination = true
    }

    tags = {
        Name = each.key
    }
}
