variable "lambda_function_name" {
  description = "The name of the Lambda function to create"
  default     = "notify_slack"
}

variable "slack_webhook_url_ssm_path" {
  description = "The SSM paramether path to the URL of Slack webhook"
}

variable "slack_channel" {
  description = "The name of the channel in Slack for notifications"
}

variable "slack_username" {
  description = "The username that will appear on Slack messages"
}

variable "slack_emoji" {
  description = "A custom emoji that will appear on Slack messages"
  default     = ":aws:"
}

data "aws_caller_identity" "current" {}

locals {
  // Add all your AWS account ID's under a suitable name
  admin_account_id = "867697617212"
  test_account_id  = "345532866871"
  prod_account_id  = ""
}