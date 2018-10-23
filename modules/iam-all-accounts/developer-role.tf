
resource "aws_iam_role" "developer" {
  name               = "developer"
  assume_role_policy = "${data.aws_iam_policy_document.developer_assume_policy.json}"
}

data "aws_iam_policy_document" "developer_assume_policy" {
  statement {
    effect  = "Allow"
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${local.admin_account_id}:root",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

//resource "aws_iam_policy" "developer_role_policy" {
//  name        = "developer_policy"
//  description = "developer role - full AWS permissions"
//  policy      = "${data.aws_iam_policy_document.developer_role_policy.json}"
//}
//
//data "aws_iam_policy_document" "developer_role_policy" {
//  statement {
//    effect    = "Allow"
//    actions   = [""]
//    resources = [""]
//  }
//}
//
//resource "aws_iam_role_policy_attachment" "developer_role_policy" {
//  policy_arn = "${aws_iam_policy.developer_role_policy.arn}"
//  role       = "${aws_iam_role.developer.name}"
//}


