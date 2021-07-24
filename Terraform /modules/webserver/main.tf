resource "aws_security_group" "minanode-sg" {
    name = "minanode-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my_ip] 
    }

    ingress {
        from_port = 443
        to_port = 443
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
        from_port = 8302
        to_port = 8302
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }

    ingress {
        from_port = 9100
        to_port = 9100
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      prefix_list_ids = []
    } 

    tags = {
        Name: "${var.env_prefix}-sg"
    }
}

data "aws_ami" "latest-ubuntu-server-image" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = [var.image_name]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
  
}


resource "aws_instance" "minanode-server" {
    ami = data.aws_ami.latest-ubuntu-server-image.id
    instance_type = var.instance_type

    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_security_group.minanode-sg.id]
    availability_zone = var.avail_zone

    associate_public_ip_address = true
    key_name = "minanode"

    user_data = file("minanode-script.sh")   
    
    tags = {
        Name = "${var.env_prefix}-server"
    }
}