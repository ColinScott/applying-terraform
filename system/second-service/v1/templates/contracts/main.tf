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

resource "aws_security_group" "first_service" {
  name = "second-service-${var.dc_name}-v1"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
}