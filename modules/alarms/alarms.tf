// Cloudwatch alarms can be used to trigger this lambda
// https://www.terraform.io/docs/providers/aws/r/cloudwatch_metric_alarm.html

resource "aws_cloudwatch_metric_alarm" "test-alarm" {
  alarm_name                = "${var.environment}-prove-slack-notification-alarm"

// The following metrics are compatible
// https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
  metric_name               = "BucketSizeBytes"
  namespace                 = "AWS/S3"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  period                    = "86400"
  statistic                 = "Average"
  threshold                 = "1000"

  insufficient_data_actions = []
  alarm_description         = "This metric monitors S3 storage quantities in bytes"
  alarm_actions             = ["${var.notify_slack_topic_arn}"]
}