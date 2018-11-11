locals {
  sns_topic_name = ["${var.environment}-upload-sns-topic"]
}

resource "aws_sns_topic" "upload-sns-topic" {
  name = ["${local.sns_topic_name}"]
  //retry policy here might be nice
}
output "arn" {
  value = "${aws_s3_bucket.cloudtrail_logs.id}"
}