locals {
  sns_topic_name = "${var.environment}-upload-sns-topic"
}

resource "aws_sns_topic" "upload-sns-topic" {
  name = "${local.sns_topic_name}"
  //retry policy here might be nice
}