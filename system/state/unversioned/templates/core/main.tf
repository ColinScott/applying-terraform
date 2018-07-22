provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" {
  name = "abstractcode-test-terraform-${var.dc_name}"
}

resource "aws_dynamodb_table" "terraform_statelock" {
  name           = "Terraform.State.Lock.${var.dc_name}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
