resource "aws_sns_topic" "slack_notification" {
  name = "slack_notification"
}

resource "aws_sns_topic_policy" "shared_accounts" {
  arn     = "${aws_sns_topic.slack_notification.arn}"
  policy = "${data.aws_iam_policy_document.sns_cross_account.json}"
}

data "aws_iam_policy_document" "sns_cross_account" {

  statement {
    actions = [
      "SNS:Publish",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${local.admin_account_id}:root",
        "arn:aws:iam::${local.test_account_id}:root",
      ]
    }

    resources = [
      "${aws_sns_topic.slack_notification.arn}",
    ]
  }

  statement {
    actions = [
      "SNS:Publish",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${local.test_account_id}:role/aws-service-role/cloudwatch.amazonaws.com/*",
        "arn:aws:iam::${local.admin_account_id}:role/aws-service-role/cloudwatch.amazonaws.com/*",
      ]
    }

    resources = [
      "${aws_sns_topic.slack_notification.arn}",
    ]
  }
}

resource "aws_sns_topic_subscription" "sns_notify_slack" {
  topic_arn = "${aws_sns_topic.slack_notification.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.notify_slack.0.arn}"
}
