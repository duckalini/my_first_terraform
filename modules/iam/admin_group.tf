// Admin group set up

resource "aws_iam_group" "admins" {
  name = "Admins"
}

resource "aws_iam_policy" "admin_access" {
  name = "AdminAccess"
  description = "Full AWS access rights"
  policy = "${data.aws_iam_policy_document.admin_access.json}"
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
  name       = "admin_attachment"
  groups     = ["${aws_iam_group.admins.name}"]
  policy_arn = "${aws_iam_policy.admin_access.arn}"
}
