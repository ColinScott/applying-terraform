variable "vpc_id" {}

variable "private_cidr" {}
variable "private_subnets" {
  type = "list"
}

variable "restricted_cidr" {}
variable "restricted_subnets" {
  type = "list"
}
