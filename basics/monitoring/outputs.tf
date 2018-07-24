output "notification_arn" {
  value = "${aws_sns_topic.test.arn}"
}

output "log_group_arn" {
  value = "${aws_cloudwatch_log_group.test.arn}"
}