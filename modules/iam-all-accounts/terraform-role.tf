
resource "aws_iam_role" "terraform" {
  name               = "terraform"
  assume_role_policy = "${data.aws_iam_policy_document.terraform_assume_policy.json}"
}

data "aws_iam_policy_document" "terraform_assume_policy" {
  statement {
    effect  = "Allow"
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      identifiers = [
        "arn:aws:iam::${local.admin_account_id}:root",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
      type        = "AWS"
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_policy" "terraform_role_policy" {
  name        = "terraform_policy"
  description = "terraform role - full AWS permissions"
  policy      = "${data.aws_iam_policy_document.terraform_role_policy.json}"
}

data "aws_iam_policy_document" "terraform_role_policy" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "terraform_role_policy" {
  policy_arn = "${aws_iam_policy.terraform_role_policy.arn}"
  role       = "${aws_iam_role.terraform.name}"
}
