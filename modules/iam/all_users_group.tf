// All users group set up
resource "aws_iam_group" "all_users" {
  name = "All"
}

resource "aws_iam_policy" "all_users_access" {
  name        = "AllAccess"
  description = "Allow basic user account management"
  policy      = "${data.aws_iam_policy_document.all_user_access.json}"
}

// Grants permissions for users to... change password, add and remove ssh keys, access tokens and MFA devices for their own user only.
data "aws_iam_policy_document" "all_user_access" {
  statement {
    actions = [
      "iam:ChangePassword",
      "iam:*LoginProfile",
      "iam:*AccessKey*",
      "iam:*SSHPublicKey*",
    ]

    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }

  statement {
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:DeleteVirtualMFADevice",
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:mfa/$${aws:username}",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/$${aws:username}",
    ]
  }

  statement {
    actions = [
      "iam:GetAccountPasswordPolicy",
    ]

    resources = [
      "*",
    ]
  }
}
