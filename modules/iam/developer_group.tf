// Developer group set up

resource "aws_iam_group" "developers" {
  name = "Developers"
}

// Allow users in the developer group to assume the developer role
resource "aws_iam_group_policy" "allow_developer_group_to_assume_role" {
  group = "${aws_iam_group.developers}"
  policy = "${aws_iam_policy.allow_developer_group_to_assume_role.arn}"
}

resource "aws_iam_policy" "allow_developer_group_to_assume_role" {
  policy = "${data.aws_iam_policy_document.allow_groups_to_assume_developer_role.json}"
}

data "aws_iam_policy_document" "allow_groups_to_assume_developer_role" {
    statement {
    actions = [
      "sts:AssumeRole",
    ]

    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/developer_role",
    ]
  }
}

// Role set up

resource "aws_iam_role" "developer_role" {
  assume_role_policy = "${aws_iam_policy.developer_assume_role.arn}"
}

resource "aws_iam_role_policy" "developer_role_trust_policy" {
  policy = "${aws_iam_policy.developer_role_trust_policy.arn}"
  role = "${aws_iam_role.developer_role.id}"
}

// Assume role set up
data "aws_iam_policy_document" "developer_role_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type = "AWS"
    }
  }
}




// Permissions for the developer role - access to various AWS services

resource "aws_iam_policy" "developer_role_access" {
  name = "DeveloperAccess"
  description = "Least privilege AWS access rights"
  policy = "${data.aws_iam_policy_document.developer_role_access.json}"
}

data "aws_iam_policy_document" "developer_role_access" {
    statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "*",
    ]
  }
}