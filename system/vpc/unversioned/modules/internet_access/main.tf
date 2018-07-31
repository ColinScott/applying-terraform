resource "aws_internet_gateway" "gateway" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "main"
  }
}

resource "aws_eip" "nat" {
  count = "${var.create_nat == "true" ? length(var.public_subnets) : 0}"

  vpc = true

  depends_on = ["aws_internet_gateway.gateway"]
}

resource "aws_nat_gateway" "nat" {
  count = "${var.create_nat == "true" ? length(var.public_subnets) : 0}"

  allocation_id = "${aws_eip.nat.*.id[count.index]}"
  subnet_id     = "${var.public_subnets[count.index]}"

  depends_on = ["aws_eip.nat"]
}