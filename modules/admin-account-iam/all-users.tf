// All users group set up
resource "aws_iam_group" "all_users" {
  name = "AllUsers"
}

resource "aws_iam_group_policy" "all_users_access" {
  name   = "AllUsersAccess"
  group  = "${aws_iam_group.all_users.name}"
  policy = "${data.aws_iam_policy_document.all_users.json}"
}

// Grants permissions for users to... change password, add and remove ssh keys, access tokens and MFA devices for their own user only.
data "aws_iam_policy_document" "all_users" {
  statement {
    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:*LoginProfile",
      "iam:*AccessKey*",
      "iam:*SSHPublicKey*",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:DeleteVirtualMFADevice",
    ]

    resources = [
      "arn:aws:iam::account-id-without-hyphens:mfa/$${aws:username}",
      "arn:aws:iam::account-id-without-hyphens:user/$${aws:username}",
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["iam:GetAccountPasswordPolicy"]
    resources = ["*"]
  }
}

resource "aws_iam_group_membership" "all_users" {
  name  = "all_users"
  users = ["${local.all_users}"]
  group = "${aws_iam_group.all_users.name}"
}
