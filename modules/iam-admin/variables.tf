locals {
  // Add all your AWS account ID's under a suitable name
  admin_account_id = "867697617212"
  test_account_id  = "345532866871"
  prod_account_id  = ""

  // Decide which roles your admin users will have access to
  admin_roles = [
    "admin",
    "readonly",
    "terraform",
  ]

  // Decide which accounts your admin users will have access to
  admin_accounts = [
    "${local.admin_account_id}",
    "${local.test_account_id}",
    "${local.prod_account_id}",
  ]

  // Decide which roles your dev users will have access to
  developer_roles = [
    "developer",
    "readonly",
  ]

  // Decide which accounts your dev users will have access to
  developer_accounts = [
    "${local.test_account_id}",
  ]

  // A list of all users, add any additional user groups in to this list
  all_users = "${concat(var.admin_users, var.developer_users)}"
}

variable "admin_users" {
  description = "A list of all admin users"
  type        = "list"
  default     = [""]
}

variable "developer_users" {
  description = "A list of all developer users"
  type        = "list"
  default     = [""]
}
