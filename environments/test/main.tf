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
  version             = "1.30.0"
  region              = "us-west-2"
  allowed_account_ids = ["${local.account_id}"]
}

# Your individual environment config starts here - it can include simple Terraform resources or modules
# Modules are a reusable collection of resources bundled together with inputs and / or outputs to help configure them for your environment needs

# TODO Import the IAM module to create admin & dev user roles and groups

module "iam" {
  source = "../../modules/iam"

  environment = "test"
}
