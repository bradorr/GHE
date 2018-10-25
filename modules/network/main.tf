data "aws_availability_zones" "available" {}

locals {
  common_tags = {
    Owner       = "${var.owner}"
    Purpose     = "${var.purpose}"
    Environment = "${var.environment}"
  }

  name_prefix = "${var.owner}-${var.environment}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "ghe-vpc" {
  cidr_block = "${var.vpc_cidr}"

  tags = "${merge(
      local.common_tags,
      map(
        "Name", "${local.name_prefix}-vpc"
      )
    )}"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.ghe-vpc.id}"

  tags = "${merge(
      local.common_tags,
      map(
        "Name", "${local.name_prefix}-gw"
      )
    )}"
}

resource "aws_subnet" "main" {
  count             = "${var.subnet_count}"
  vpc_id            = "${aws_vpc.ghe-vpc.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"
  map_public_ip_on_launch = true

  tags = "${merge(
      local.common_tags,
      map(
        "Name", "${local.name_prefix}-main-${count.index}"
      )
    )}"
}

resource "aws_ebs_volume" "ghe" {
    availability_zone = "${var.ebs_az}"

    tags {
        Name = "ghe-ebs"
    }
}