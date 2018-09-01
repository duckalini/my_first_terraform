// Developer group set up
resource "aws_iam_group" "developer" {
  name = "Developer"
}

resource "aws_iam_policy" "dev_access" {
  name        = "DeveloperAccess"
  description = "Developer AWS access rights"
  policy      = "${data.aws_iam_policy_document.dev_access.json}"
}

// Allow developer group to assume the developer role
data "aws_iam_policy_document" "developer_users_can_assume_roles" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/dev",
    ]

    condition = {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

// Create developer role with developer permissions
resource "aws_iam_role" "dev" {
  name = "dev"
  path = "/"

  assume_role_policy = "${data.aws_iam_policy_document.dev_trust_policy.json}"
}

data "aws_iam_policy_document" "dev_access" {
  statement {
    actions = [
      "s3:*",
      "sqs:*",
      "sns:*",
      "lambda:*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy_attachment" "dev_attach" {
  name       = "dev_attachment"
  groups     = ["${aws_iam_group.developer.name}"]
  policy_arn = "${aws_iam_policy.dev_access.arn}"
}

// Developer role trust policy - which IAM groups / AWS accounts can assume the developer role
data "aws_iam_policy_document" "dev_trust_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals = [
      {
        type = "AWS"

        identifiers = [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        ]
      },
    ]

    condition = {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}
