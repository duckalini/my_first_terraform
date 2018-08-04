# Initial terraform set up required

terraform {
  required_version = ">= 0.11.7"        # every IC needs to have this version of terraform installed

  backend "s3" {
    encrypt = "true"
    bucket  = "my-first-terraform-test" # manually created bucket to store your statefile, this must be gloablly unique
    key     = "test/terraform.tfstate"  # state file name (including it's path)
    region  = "us-west-2"
  }
}

provider "aws" {
  version             = "1.30.0"
  region              = "us-west-2"
  allowed_account_ids = ["${local.account_id}"]
}

# Your individual environment config starts here

