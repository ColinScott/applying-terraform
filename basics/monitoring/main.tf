resource "aws_cloudwatch_log_group" "test" {
  name = "test/${var.dc_name}"
  retention_in_days = 365
}

resource "aws_sns_topic" "test" {
  name = "test-${var.dc_name}"
}