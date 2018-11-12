resource "aws_sns_topic" "slack_notification" {
  name = "slack_notification"
}

resource "aws_sns_topic_policy" "shared_accounts" {
  arn     = "${aws_sns_topic.slack_notification.arn}"
  policy = "${data.aws_iam_policy_document.sns_cross_account.json}"
}

data "aws_iam_policy_document" "sns_cross_account" {
  statement {
    sid = "AllowLocalLambdaToSubscribeToTopic"
    effect = "Allow"
    actions = [
        "sns:Subscribe",
        "sns:Receive",
    ]

    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${local.admin_account_id}:root",
      ]
    }
    resources = ["${aws_sns_topic.slack_notification.arn}"]
  }

  // https://forums.aws.amazon.com/thread.jspa?threadID=229533
  statement {
    sid = "AllowCloudWatchAlarmsToPublish"
    effect = "Allow"
    actions = [
      "SNS:Publish",
    ]

    principals {
      type        = "AWS"
      identifiers = [
        "*"
      ]
    }

    condition {
      test = "StringEquals"
      values = [
        "${local.admin_account_id}",
        "${local.test_account_id}",
      ]
      variable = "AWS:SourceOwner"
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
