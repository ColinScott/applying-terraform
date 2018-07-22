resource "aws_cloudwatch_metric_alarm" "not_processing" {
  alarm_name = "search-${var.queue_name}-not-processing"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "ApproximateNumberOfMessagesVisible"
  namespace = "AWS/SQS"
  dimensions {
    QueueName = "${var.queue_name}"
  }
  period = "60"
  statistic = "Average"
  threshold = "500"
  alarm_description = "${var.queue_name} in ${var.dc_name} is backing up"
  alarm_actions = ["${var.notification_arn}"]
}