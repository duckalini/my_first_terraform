locals {
  environment      = "admin"
  project_name     = "my-first-terraform"
  admin_account_id = "867697617212"
  test_account_id  = "345532866871"
}

data "aws_caller_identity" "current" {}
