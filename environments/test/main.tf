# Initial terraform set up required -  for information on this see `101 get started` environment
terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    encrypt = "true"
    bucket  = "my-first-terraform-test"
    key     = "test/terraform.tfstate"
    region  = "us-west-2"
  }
}

provider "aws" {
  version             = "1.40.0"
  region              = "us-west-2"
  allowed_account_ids = ["${var.test_account_id}"]
}

# Your individual environment config starts here - it can include simple Terraform resources or modules
# Modules are a reusable collection of resources bundled together with inputs and / or outputs to help configure them for your environment needs

// Configure cloudtrail to audit infrastructure changes
module "cloudtrail" {
  source      = "../../modules/cloudtrail"
  environment = "test"
  project     = "my-first-terraform"
}

// Create all the required IAM roles
module "iam-roles" {
  source = "../../modules/iam-all-accounts"
}

// Create alarms and send notifications to slack lambda in admin account
module "alarms" {
  source                  = "../../modules/alarms"
  environment             = "${local.environment}"
  notify_slack_topic_arn  = "arn:aws:sns:us-west-2:867697617212:slack_notification"
}