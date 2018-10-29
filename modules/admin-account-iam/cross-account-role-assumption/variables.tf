variable "account" {
  description = "The account the group will be assuming roles in to"
}

variable "environment" {
  description = "The environment name for the account, used for naming the policy"
}

variable "roles" {
  description = "List of roles the group will be allowed to assume"
  type        = "list"
}

variable "group_id" {
  description = "The ID of the IAM group"
}
