provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "minanode-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: "${var.env_prefix}-vpc"
    }
}

module "minanode-subnet" {
    source = "./modules/subnet"
    subnet_cidr_block = var.subnet_cidr_block
    avail_zone  = var.avail_zone
    env_prefix = var.env_prefix
    vpc_id = aws_vpc.minanode-vpc.id
    default_route_table_id = aws_vpc.minanode-vpc.default_route_table_id

}

module "minanode-server" {
    source = "./modules/webserver"

    avail_zone = var.avail_zone

    env_prefix = var.env_prefix

    vpc_id = aws_vpc.minanode-vpc.id

    my_ip = var.my_ip

    image_name = var.image_name

    subnet_id = module.minanode-subnet.subnet.id

    instance_type = var.instance_type
}