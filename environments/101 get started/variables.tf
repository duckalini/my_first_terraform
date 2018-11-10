# locals variables are really useful if you're going to be typing the same thing many times.
# It should also be something that isn't going to change. They are especially useful when you what to define a whole block or calculate something based on a variable value.
# Find out more about them at https://www.terraform.io/docs/configuration/locals.html)
locals {
  environment      = "environment"
  project_name     = "project-or-company"
}

data "aws_caller_identity" "current" {}

variable "account_id" {
  default = "123456789"
}
