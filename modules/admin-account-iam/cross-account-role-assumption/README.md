# cross-account-role-assumption

## Purpose
Create an IAM policy which allows an IAM group to assume one or more roles in a user account.
This module is used for each environment, for each user group.

## Usage
This will list off any inputs that are required and whether or not they have a default variable. 

| Variable name | Description | Default Y/N | Default value|
|---------------|-------------|-------------|--------------|
| environment | Name of the environment the group will be assuming roles in this should be kept short | N | |
| account | The AWS account ID of the environment the group will be assuming roles in to | N | |
| group_id | The ID of the IAM group | N | |
| roles | A list of role names that the group is allowed to assume | N | |
