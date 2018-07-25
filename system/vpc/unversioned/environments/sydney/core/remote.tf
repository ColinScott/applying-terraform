terraform {
  backend "s3" {
    bucket = "abstractcode-test-terraform-sydney"
    key    = "vpc/core/terraform.tfstate"
    region = "ap-southeast-2"
    dynamodb_table = "Terraform.State.Lock.sydney"
  }
}