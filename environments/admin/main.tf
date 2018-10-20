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
  version             = "1.30.0"
  region              = "us-west-2"
  allowed_account_ids = ["${var.account_id}"]

//  assume_role {
//    role_arn     = "arn:aws:iam:867697617212:role/terraform"
//    session_name = "terraform"
//  }
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

// Create all the IAM groups with iam-admin module

// Create all the IAM roles with iam-all-accounts module
