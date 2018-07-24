output "vpc_id" {
  value = "${aws_vpc.test.id}"
}

output "public_subnets" {
  value = "${aws_subnet.public.*.id}"
}

output "private_subnets" {
  value = "${aws_subnet.private.*.id}"
}

output "restricted_subnets" {
  value = "${aws_subnet.restricted.*.id}"
}