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
  allowed_account_ids = ["123456789"]
}

# Your individual environment config starts here - it can include simple Terraform resources or modules
# Modules are a reusable collection of resources bundled together with inputs and / or outputs to help configure them for your environment needs

// Configure the account with starting tools
module "account-config" {
  source      = "../../modules/account-config"
  environment = "test"
  project     = "my-first-terraform"
}

module "iam-roles" {
  source = "../../modules/iam-all-accounts"
}
