provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "test" {
  cidr_block = "${var.cidr}"
}

data "aws_availability_zones" "zones" {
  region = "${var.region}"
}

resource "aws_subnet" "public" {
  count = "${length(data.aws_availability_zones.zones)}"

  vpc_id = "${aws_vpc.test.id}"
  cidr_block = ""
}

