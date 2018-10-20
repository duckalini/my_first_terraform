
resource "aws_iam_role" "readonly" {
  name               = "readonly"
  assume_role_policy = "${data.aws_iam_policy_document.readonly_assume_policy.json}"
}

data "aws_iam_policy_document" "readonly_assume_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      identifiers = [
        "arn:aws:iam:${local.admin_account_id}:root",
        "arn:aws:iam:${data.aws_caller_identity.current.account_id}:root",
      ]
      type        = "AWS"
    }

    condition {
      test     = "Bool"
      values   = ["aws:MultiFactorAuthPresent"]
      variable = "true"
    }
  }
}

resource "aws_iam_policy" "readonly_role_policy" {
  name        = "readonly_policy"
  description = "readonly role - full AWS permissions"
  policy      = "${data.aws_iam_policy_document.readonly_role_policy.json}"
}

data "aws_iam_policy_document" "readonly_role_policy" {
  statement {
    effect    = "Allow"
    actions   = [
      "s3:Get*",
      "s3:List*",
      "lambda:Get*",
      "lambda:List*",
      "lambda:InvokeFunction",
      "sqs:Get*",
      "sqs:List*",
      "sns:Get*",
      "sns:List*",
      "dynamo:Get*",
      "dynamo:List*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "readonly_role_policy" {
  policy_arn = "${aws_iam_policy.readonly_role_policy.arn}"
  role       = "${aws_iam_role.readonly.name}"
}

