provider "aws" {
  region = "${var.region}"
}

resource "aws_sqs_queue" "first_test" {
  name = "basic-test-first-${var.dc_name}"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "second_test" {
  name = "basic-test-second-${var.dc_name}"
  message_retention_seconds = 30
}

module "monitoring" {
  source = "../monitoring"

  dc_name = "${var.dc_name}"
}

module "first_queue_alarms" {
  source = "../queue_alarms"

  dc_name = "${var.dc_name}"
  notification_arn = "${module.monitoring.notification_arn}"
  queue_name = "${aws_sqs_queue.first_test.name}"
}

module "second_queue_alarms" {
  source = "../queue_alarms"

  dc_name = "${var.dc_name}"
  notification_arn = "${module.monitoring.notification_arn}"
  queue_name = "${aws_sqs_queue.second_test.name}"
}

data "aws_sqs_queue" "third_test" {
  name = "basic-test-third-${var.dc_name}"
}


module "third_queue_alarms" {
  source = "../queue_alarms"

  dc_name = "${var.dc_name}"
  notification_arn = "${module.monitoring.notification_arn}"
  queue_name = "${data.aws_sqs_queue.third_test.name}"
}