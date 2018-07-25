output "vpc_id" {
  value = "${aws_vpc.test.id}"
}

output "public_subnets" {
  value = "${aws_subnet.public.*.id}"
}

output "public_cidr" {
  value = "${local.public_cidr}"
}

output "private_subnets" {
  value = "${aws_subnet.private.*.id}"
}

output "private_cidr" {
  value = "${local.private_cidr}"
}

output "restricted_subnets" {
  value = "${aws_subnet.restricted.*.id}"
}

output "restricted_cidr" {
  value = "${local.restricted_cidr}"
}