resource "aws_iam_role" "finance" {
  name               = "finance"
  assume_role_policy = "${data.aws_iam_policy_document.finance_assume_role_policy.json}"
}

resource "aws_iam_role_policy" "finance" {
  role        = "${aws_iam_role.finance.id}"
  name_prefix = "finance"
  policy      = "${data.aws_iam_policy_document.finance.json}"
}

data "aws_iam_policy_document" "finance" {
  statement {
    effect = "Allow"

    actions = [
      "ce:GetCostAndUsage",
      "ce:GetDimensionValues",
      "ce:GetReservationUtilization",
      "ce:GetTags",
      "cur:DescribeReportDefinitions",
      "cur:DeleteReportDefinition",
      "cur:PutReportDefinition",
      "aws-portal:ViewAccount",
      "aws-portal:ViewBilling",
      "aws-portal:ViewPaymentMethods",
      "aws-portal:ViewUsage",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "finance_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals = [
      {
        type = "AWS"

        identifiers = [
          "arn:aws:iam::${local.admin_account_id}:root",
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