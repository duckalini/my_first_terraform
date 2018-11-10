# Initial terraform set up required -  for information on this see `101 get started` environment
terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    encrypt = "true"
    bucket  = "my-first-terraform-admin"
    key     = "admin/terraform.tfstate"
    region  = "us-west-2"
  }
}

provider "aws" {
  region              = "us-west-2"
  allowed_account_ids = ["${var.account_id}"]
  version             = "= 1.40.0"
}

// Configure the basic IAM security settings on your main account

resource "aws_iam_account_password_policy" "password_policy" {
  minimum_password_length        = 20
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
  allow_users_to_change_password = true
}

// Create all the IAM groups with admin-account-iam module
module "iam-groups" {
  source = "../../modules/admin-account-iam"

  admin_users = [
    "alix.klingenberg",
    "duck.lawn",
  ]

  developer_users = [
    "duck.lawn",
  ]
}

// Configure cloudtrail to audit infrastructure changes
module "cloudtrail" {
  source      = "../../modules/cloudtrail"
  environment = "admin"
  project     = "my-first-terraform"
}

// Create all the required IAM roles for users
module "iam-roles" {
  source = "../../modules/iam-all-accounts"
}
