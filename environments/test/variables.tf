locals {
  environment     = "test"
  project_name    = "my-first-terraform"
  test_account_id = "345532866871"
}

variable "test_account_id" {
  default = "345532866871"
}
