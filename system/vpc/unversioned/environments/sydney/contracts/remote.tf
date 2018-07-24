terraform {
  backend "s3" {
    bucket = "abstractcode-test-terraform-sydney"
    key    = "vpc/terraform.tfstate"
    region = "ap-southeast-2"
    dynamodb_table = "Terraform.State.Lock.sydney"
  }
}