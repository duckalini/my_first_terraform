# Everything you need to get started with terraform is in this file

terraform {
  required_version = ">= 0.11.7"        # Install terraform then check your version number (you can use brew) or https://www.terraform.io/downloads.html
                                        # every IC needs to have this version of terraform installed

  backend "s3" {
    encrypt = "true"
    bucket  = "my-first-terraform-test" # A manually created bucket to store your statefile, it must be gloablly unique and in your AWS account
    key     = "test/terraform.tfstate"  # Your state file name within S3, give it a useful path as you might have multiple of these per AWS account
    region  = "us-west-2"
  }
}

provider "aws" {
  version             = "1.30.0"        # Each provider (aws, azure, gcp) needs up to date resources
                                        # Find the latest version and set it  https://github.com/terraform-providers/terraform-provider-aws
                                        # Update this regularly to support new AWS services, you'll need to run terraform init after you update it
  region              = "us-west-2"     # Your default aws region
  allowed_account_ids = ["123456789"]   # You aws account ID needs to go here.
}

# Your individual environment config starts here - see other environments for these components.

