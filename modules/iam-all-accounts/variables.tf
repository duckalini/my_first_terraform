locals {
  // Add all your AWS account ID's under a suitable name
  admin_account_id = "867697617212"
  test_account_id  = "345532866871"
  prod_account_id  = ""
}

data "aws_caller_identity" "current" {}
