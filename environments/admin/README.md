# Admin account

This is a separate AWS account used for managing your IAM users, as well as your test and production infrastructure.

This account will set up:
* IAM user groups
* IAM assume role permissions with test and production
* SNS topic (and lambda?) used to send messages to Slack
* Any other shared infrastructure that is not your test and production environments


IAM roles are used for XYZ