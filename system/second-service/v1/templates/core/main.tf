provider "aws" {
  region = "${var.region}"

  version = ">= 1.29"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "abstractcode-test-terraform-${var.dc_name}"
    key    = "vpc/contracts/terraform.tfstate"
    region = "${var.region}"
  }
}

data "terraform_remote_state" "contacts_v1" {
  backend = "s3"
  config {
    bucket = "abstractcode-test-terraform-${var.dc_name}"
    key    = "services/second/v1/contracts/terraform.tfstate"
    region = "${var.region}"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2*"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "service" {
  ami = "${data.aws_ami.amazon_linux.id}"
  instance_type = "${var.instance_type}"

  key_name = "second-service-${var.dc_name}-v1"

  subnet_id = "${data.terraform_remote_state.vpc.private_subnets[0]}"
  vpc_security_group_ids = ["${data.terraform_remote_state.contacts_v1.security_group_id}"]
}
