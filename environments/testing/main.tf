terraform {
  required_version = "> 0.11.7"

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
  allowed_account_ids = ["345532866871"]
}

