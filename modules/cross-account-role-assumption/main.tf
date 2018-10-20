resource "aws_iam_group_policy" "assume_role" {
  name   = "${var.environment}-cross-account-policy"
  group  = "${var.group_id}"
  policy = "${data.aws_iam_policy_document.cross_account_assume_role.json}"
}

data "aws_iam_policy_document" "cross_account_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      "${formatlist("arn:aws:iam:%s:role/%s", var.account, var.roles)}",
    ]
  }
}
