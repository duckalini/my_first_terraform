// Developer group set up
resource "aws_iam_group" "developer" {
  name = "Developer"
}

resource "aws_iam_group_membership" "developer_users" {
  name  = "developer_users"
  users = ["${var.developer_users}"]
  group = "${aws_iam_group.developer.name}"
}

// cross account role assumption set up, one module per account
module "test_account_developer_group_assume_role_access" {
  source      = "./cross-account-role-assumption"
  environment = "test"
  account     = "${local.test_account_id}"
  group_id    = "${aws_iam_group.developer.id}"

  roles = [
    "developer",
    "readonly",
  ]
}
