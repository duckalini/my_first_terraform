// Admin group set up

resource "aws_iam_group" "admins" {
  name = "Admin"
}

resource "aws_iam_policy" "admin_access" {
  name = "AdminAccess"
  description = "Full AWS access rights"
  policy = "${data.aws_iam_policy_document.admin_access.json}"
}

// Allow admin group to assume all roles
data "aws_iam_policy_document" "admin_users_can_assume_roles" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/admin",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/dev",
    ]

    condition = {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

// Create admin role with admin permissions
resource "aws_iam_role" "admin" {
  name = "admin"
  path = "/"

  assume_role_policy = "${data.aws_iam_policy_document.admin_trust_policy.json}"
}

data "aws_iam_policy_document" "admin_access" {
    statement {
    actions = [
      "*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy_attachment" "admin_attach" {
  name       = "admin_attach"
  groups     = ["${aws_iam_group.admins.name}"]
  policy_arn = "${aws_iam_policy.admin_access.arn}"
}

// Admin role trust policy - which IAM groups / AWS accounts can assume the admin role
data "aws_iam_policy_document" "admin_trust_policy" {
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
