terraform {
  backend "s3" {
    bucket = "abstractcode-test-terraform-singapore"
    key    = "vpc/terraform.tfstate"
    region = "ap-southeast-1"
    dynamodb_table = "Terraform.State.Lock.singapore"
  }
}