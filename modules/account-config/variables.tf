variable "environment" {}

variable "project" {
  description = "A unique project name, used to create unique resource names in AWS. i.e. Company name"
}

data "aws_caller_identity" "current" {}

locals {
  // Add all your AWS account ID's under a suitable name
  admin_account_id = "867697617212"
  test_account_id  = "345532866871"
  prod_account_id  = ""

}