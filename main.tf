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

resource "aws_instance" "ghe" {
  ami = "${var.ghe_ami}"
  instance_type = "${var.ghe_type}"
  ebs_optimized = true
  ebs_block_device = "${aws_ebs_volume.ghe.arn}"

}

resource "aws_eip" "ghe" {
  instance = "${aws_instance.ghe.id}"
  vpc = true
}

resource "aws_security_group" "ghe" {
  description = "allow cloudreach ip to access needed ports"
  vpc_id = "${aws_vpc.ghe-vpc.id}"
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["${var.permited_ip}"]
  }
  ingress {
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["${var.permited_ip}"]
  }
  ingress {
    from_port = "8080"
    to_port = "8080"
    protocol = "tcp"
    cidr_blocks = ["${var.permited_ip}"]
  }
  ingress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = ["${var.permited_ip}"]
  }
  ingress {
    from_port = "8443"
    to_port = "8443"
    protocol = "tcp"
    cidr_blocks = ["${var.permited_ip}"]
  }
  ingress {
    from_port = "25"
    to_port = "25"
    protocol = "tcp"
    cidr_blocks = ["${var.permited_ip}"]
  }
  ingress {
    from_port = "1194"
    to_port = "1194"
    protocol = "tcp"
    cidr_blocks = ["${var.permited_ip}"]
  }
  ingress {
    from_port = "1194"
    to_port = "1194"
    protocol = "udp"
    cidr_blocks = ["${var.permited_ip}"]
  }
  ingress {
    from_port = "122"
    to_port = "122"
    protocol = "tcp"
    cidr_blocks = ["${var.permited_ip}"]
  }
  ingress {
    from_port = "9418"
    to_port = "9418"
    protocol = "tcp"
    cidr_blocks = ["${var.permited_ip}"]
  }
  ingress {
    from_port = "123"
    to_port = "123"
    protocol = "udp"
    cidr_blocks = ["${var.permited_ip}"]
  } 
  ingress {
    from_port = "161"
    to_port = "161"
    protocol = "udp"
    cidr_blocks = ["${var.permited_ip}"]
  } 
}