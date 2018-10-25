provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_vpc" "ghe-vpc" {
    cidr_block = "${var.vpc_cidr}"
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.ghe-vpc.id}"
}

resource "aws_subnet" "main" {
    vpc_id = "${aws_vpc.ghe-vpc.id}"
    cidr_block = "${var.subnet_cidr}"
    map_public_ip_on_launch = true
}

resource "aws_ebs_volume" "ghe" {
    availability_zone = "${var.ebs_az}"
    type = "${var.ebs_type}"
    size = "${var.ebs_size}"
}
