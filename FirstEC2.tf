#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
    access_key = "AKIAW35QUDEIVYHQTMV4"
    secret_key = "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"
    region = "us-east-1"
}

resource "aws_security_group" "securiy_port"{
    name = "securiy_port"
    description = "sg for new instance"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "securiy_port"
    }
}   
resource "aws_vpc" "prod-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "prod-vpc"
    }
}
resource "aws_subnet" "prod-subnet-public-1" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "prod-subnet-public-1"
    }
}
resource "aws_subnet" "Private-Subnet"{
    cidr_block = "10.0.2.0/26"
    vpc_id = "${aws_vpc.prod-vpc.id}"
    tags = {
        Name = "private-subnet"
    }
}
resource "aws_internet_gateway" "IGW1"{
    vpc_id = "${aws_vpc.prod-vpc.id}"
    tags = {
        Name = "IGW1"
    }
}
resource "aws_route_table" "RT1"{
    vpc_id = "${aws_vpc.prod-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.IGW1.id}"
    }
    tags = {
        Name = "custom"
    }
}
resource "aws_route_table_association" "Route"{
    subnet_id = aws_subnet.Private-Subnet.id
    route_table_id = aws_route_table.RT1.id
}