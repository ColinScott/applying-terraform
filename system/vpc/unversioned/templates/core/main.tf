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

module "acls" {
  source = "../../../modules/acls"

  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

  private_cidr = "${data.terraform_remote_state.vpc.private_cidr}"
  private_subnets = ["${data.terraform_remote_state.vpc.private_subnets}"]

  restricted_cidr = "${data.terraform_remote_state.vpc.restricted_cidr}"
  restricted_subnets = ["${data.terraform_remote_state.vpc.restricted_subnets}"]
}

module "internet_access" {
  source = "../../../modules/internet_access"

  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

  public_subnets = ["${data.terraform_remote_state.vpc.public_subnets}"]

  create_nat = "${var.create_nat}"
}