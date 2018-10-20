resource "aws_iam_role" "admin" {
  name               = "admin"
  assume_role_policy = "${data.aws_iam_policy_document.admin_assume_policy.json}"
}

data "aws_iam_policy_document" "admin_assume_policy" {
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

resource "aws_iam_policy" "admin_role_policy" {
  name        = "admin_policy"
  description = "Admin role - full AWS permissions"
  policy      = "${data.aws_iam_policy_document.admin_role_policy.json}"
}

data "aws_iam_policy_document" "admin_role_policy" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "admin_role_policy" {
  policy_arn = "${aws_iam_policy.admin_role_policy.arn}"
  role       = "${aws_iam_role.admin.name}"
}
