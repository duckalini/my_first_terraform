# locals variables are really useful if you're going to be typing the same thing many times.
# Find out more about them at https://www.terraform.io/docs/configuration/locals.html)

locals {
  environment     = "test"
  project_name    = "my-first-terraform"
  test_account_id = "345532866871"
}

variable "test_account_id" {
  default = "345532866871"
}
