resource "aws_subnet" "minanode-subnet-1" {
    vpc_id = var.vpc_id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name: "${var.env_prefix}-subnet-1"
    }
}

resource "aws_internet_gateway" "minanode_igw" {
    vpc_id = var.vpc_id
    tags = {
        Name: "${var.env_prefix}-igw"
    }
}

resource "aws_route_table" "minanode-route-table" {
    vpc_id = var.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.minanode_igw.id}"
    }
    tags = {
        Name: "${var.env_prefix}-rtb"
    }
}

resource "aws_route_table_association" "minanode-rtb-subnet" {
    subnet_id = aws_subnet.minanode-subnet-1.id
    route_table_id = "${aws_route_table.minanode-route-table.id}"
  
}