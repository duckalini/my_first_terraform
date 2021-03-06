# Everything you need to get started with terraform is in this file

terraform {
  required_version = ">= 0.11.7" # Install terraform then check your version number (you can use brew) or https://www.terraform.io/downloads.html

  # everyone who uses this terraform project needs this version installed

  backend "s3" {
    encrypt = "true"
    bucket  = "my-first-terraform-test" # A bucket to store your statefile, it must be gloablly unique and in your AWS account. This naming convention is ${project-name}-${environment-name}
    key     = "test/terraform.tfstate"  # Your state file name within S3, give it a useful path as you might have multiple of these per AWS account
    region  = "us-west-2"
  }
}

provider "aws" {
  version = "1.30.0" # Each provider (aws, azure, gcp) needs up to date resources

  # Find the latest version and set it  https://github.com/terraform-providers/terraform-provider-aws
  # Update this regularly to support new AWS services, you'll need to run terraform init after you update it
  region = "us-west-2" # Your default aws region

  allowed_account_ids = ["123456789"] # Your aws account ID needs to go here.
}

# Your individual environment config starts here - see other environments for these components. It can include simple Terraform resources or modules
# Modules are a reusable collection of resources bundled together with inputs and / or outputs to help configure them for your environment needs
# We have created couple of modules in this repo.

