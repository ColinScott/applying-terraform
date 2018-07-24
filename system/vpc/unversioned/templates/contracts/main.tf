provider "aws" {
  region = "${var.region}"
}

locals {
  public_cidr = "${cidrsubnet(var.cidr, 2, 1)}"
  private_cidr = "${cidrsubnet(var.cidr, 2, 2)}"
  restricted_cidr = "${cidrsubnet(var.cidr, 2, 3)}"
}

resource "aws_vpc" "test" {
  cidr_block = "${var.cidr}"

  tags {
    Name = "test"
  }
}

data "aws_availability_zones" "zones" {}

resource "aws_subnet" "public" {
  count = "${length(data.aws_availability_zones.zones.names)}"

  vpc_id = "${aws_vpc.test.id}"
  cidr_block = "${cidrsubnet(local.public_cidr, 3, count.index)}"

  tags {
    Name = "Public ${count.index}"
    Type = "public"
    Count = "${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = "${length(data.aws_availability_zones.zones.names)}"

  vpc_id = "${aws_vpc.test.id}"
  cidr_block = "${cidrsubnet(local.private_cidr, 3, count.index)}"

  tags {
    Name = "Private ${count.index}"
    Type = "private"
    Count = "${count.index}"
  }
}

resource "aws_subnet" "restricted" {
  count = "${length(data.aws_availability_zones.zones.names)}"

  vpc_id = "${aws_vpc.test.id}"
  cidr_block = "${cidrsubnet(local.restricted_cidr, 3, count.index)}"

  tags {
    Name = "Restricted ${count.index}"
    Type = "restricted"
    Count = "${count.index}"
  }
}

