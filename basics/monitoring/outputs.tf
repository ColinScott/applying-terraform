output "notification_arn" {
  value = "${aws_cloudwatch_log_group.test.arn}"
}