provider "aws" {
  region = "${var.region}"
}

resource "aws_sns_topic" "events" {
  name = "first-service-events-${var.dc_name}"
}
