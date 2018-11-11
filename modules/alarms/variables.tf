variable "environment" {}

// The format of this should be arn:aws:sns:us-west-2:123456789:slack_notification
variable "notify_slack_topic_arn" {
  description = "The ARN of the SNS topic from which messages will be sent to Slack"
}
