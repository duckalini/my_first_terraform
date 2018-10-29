// Admin group set up
resource "aws_iam_group" "admin" {
  name = "Admin"
}

resource "aws_iam_group_membership" "admin_users" {
  name  = "admin_users"
  users = ["${var.admin_users}"]
  group = "${aws_iam_group.admin.name}"
}

// cross account role assumption set up, one module per account
module "test_account_admin_group_assume_role_access" {
  source      = "./cross-account-role-assumption"
  environment = "test"
  account     = "${local.test_account_id}"
  group_id    = "${aws_iam_group.admin.id}"

  roles = [
    "admin",
    "readonly",
    "terraform",
  ]
}

module "admin_account_admin_group_assume_role_access" {
  source      = "./cross-account-role-assumption"
  environment = "admin"
  account     = "${local.admin_account_id}"
  group_id    = "${aws_iam_group.admin.id}"

  roles = [
    "admin",
    "readonly",
    "terraform",
  ]
}
