resource "aws_network_acl" "restricted" {
  vpc_id = "${var.vpc_id}"

  subnet_ids = ["${var.restricted_subnets}"]

  tags {
    Name = "Restricted"
  }
}

resource "aws_network_acl_rule" "restricted_internal_ingress" {
  network_acl_id = "${aws_network_acl.restricted.id}"

  protocol = "-1"
  egress = false
  rule_action = "allow"
  rule_number = 100
  cidr_block = "${var.restricted_cidr}"
}

resource "aws_network_acl_rule" "private_to_restricted_ingress" {
  network_acl_id = "${aws_network_acl.restricted.id}"

  protocol = "-1"
  egress = false
  rule_action = "allow"
  rule_number = 110
  cidr_block = "${var.private_cidr}"
}

resource "aws_network_acl_rule" "restricted_internal_egress" {
  network_acl_id = "${aws_network_acl.restricted.id}"

  protocol = "-1"
  egress = true
  rule_action = "allow"
  rule_number = 100
  cidr_block = "${var.restricted_cidr}"
}

resource "aws_network_acl_rule" "restricted_to_private_egress" {
  network_acl_id = "${aws_network_acl.restricted.id}"

  protocol = "-1"
  egress = true
  rule_action = "allow"
  rule_number = 110
  cidr_block = "${var.private_cidr}"
}

resource "aws_network_acl" "private" {
  vpc_id = "${var.vpc_id}"

  subnet_ids = ["${var.private_subnets}"]

  tags {
    Name = "Private"
  }
}

resource "aws_network_acl_rule" "private_internal_ingress" {
  network_acl_id = "${aws_network_acl.private.id}"

  protocol = "-1"
  egress = false
  rule_action = "allow"
  rule_number = 100
  cidr_block = "${var.private_cidr}"
}

resource "aws_network_acl_rule" "restricted_to_private_ingress" {
  network_acl_id = "${aws_network_acl.private.id}"

  protocol = "-1"
  egress = false
  rule_action = "allow"
  rule_number = 110
  cidr_block = "${var.restricted_cidr}"
}

resource "aws_network_acl_rule" "private_ssh_ingress" {
  network_acl_id = "${aws_network_acl.private.id}"

  protocol = "tcp"
  egress = false
  rule_action = "allow"
  rule_number = 130
  cidr_block = "0.0.0.0/0"
  from_port = 22
  to_port = 22
}

resource "aws_network_acl_rule" "private_return_traffic_ingress" {
  network_acl_id = "${aws_network_acl.private.id}"

  protocol = "tcp"
  egress = false
  rule_action = "allow"
  rule_number = 140
  cidr_block = "0.0.0.0/0"
  from_port = 1024
  to_port = 65535
}

resource "aws_network_acl_rule" "private_internal_egress" {
  network_acl_id = "${aws_network_acl.private.id}"

  protocol = "-1"
  egress = true
  rule_action = "allow"
  rule_number = 100
  cidr_block = "${var.private_cidr}"
}

resource "aws_network_acl_rule" "private_to_restricted_egress" {
  network_acl_id = "${aws_network_acl.private.id}"

  protocol = "-1"
  egress = true
  rule_action = "allow"
  rule_number = 110
  cidr_block = "${var.restricted_cidr}"
}

resource "aws_network_acl_rule" "private_https_egress" {
  network_acl_id = "${aws_network_acl.private.id}"

  protocol = "tcp"
  egress = true
  rule_action = "allow"
  rule_number = 120
  cidr_block = "0.0.0.0/0"
  from_port = 443
  to_port = 443
}

resource "aws_network_acl_rule" "private_return_traffic_egress" {
  network_acl_id = "${aws_network_acl.private.id}"

  protocol = "tcp"
  egress = true
  rule_action = "allow"
  rule_number = 140
  cidr_block = "0.0.0.0/0"
  from_port = 32768
  to_port = 65535
}
