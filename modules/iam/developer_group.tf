// Developer group set up

resource "aws_iam_group" "developers" {
  name = "Developers"
}


// Role set up

resource "aws_iam_role" "developer_role" {
  assume_role_policy = "${aws_iam_policy.developer_assume_role.arn}"
}

// Permissions for the developer role - access to various AWS services

resource "aws_iam_policy" "developer_access" {
  name = "DeveloperAccess"
  description = "Least privilege AWS access rights"
  policy = "${data.aws_iam_policy_document.developer_access.json}"
}

data "aws_iam_policy_document" "developer_access" {
    statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy_attachment" "developer_attach" {
  name       = "developer_attachment"
  groups     = ["${aws_iam_group.developers.name}"]
  policy_arn = "${aws_iam_policy.developer_assume_role.arn}"
}



// Assume role set up

resource "aws_iam_policy" "developer_assume_role" {
  name = "DeveloperAccess"
  description = "Least privilege AWS access rights"
  policy = ""
}

data "aws_iam_policy_document" "allow_groups_to_assume_developer_role" {
    statement {
    actions = [
      "*",
    ]

    resources = [
      "*",
    ]
  }
}