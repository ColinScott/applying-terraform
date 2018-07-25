provider "aws" {
  region = "${var.region}"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "abstractcode-test-terraform-${var.dc_name}"
    key    = "vpc/contracts/terraform.tfstate"
    region = "${var.region}"
  }
}
output "thing" {
  value = "${data.terraform_remote_state.vpc.restricted_subnets}"
}
resource "aws_network_acl" "restricted" {
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

  subnet_ids = ["${data.terraform_remote_state.vpc.restricted_subnets}"]

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
  cidr_block = "${data.terraform_remote_state.vpc.restricted_cidr}"
}

resource "aws_network_acl_rule" "restricted_internal_egress" {
  network_acl_id = "${aws_network_acl.restricted.id}"

  protocol = "-1"
  egress = true
  rule_action = "allow"
  rule_number = 100
  cidr_block = "${data.terraform_remote_state.vpc.restricted_cidr}"
}

resource "aws_network_acl_rule" "private_to_restricted_ingress" {
  network_acl_id = "${aws_network_acl.restricted.id}"

  protocol = "-1"
  egress = false
  rule_action = "allow"
  rule_number = 101
  cidr_block = "${data.terraform_remote_state.vpc.private_cidr}"
}

resource "aws_network_acl_rule" "restricted_to_private_egress" {
  network_acl_id = "${aws_network_acl.restricted.id}"

  protocol = "-1"
  egress = true
  rule_action = "allow"
  rule_number = 101
  cidr_block = "${data.terraform_remote_state.vpc.private_cidr}"
}
