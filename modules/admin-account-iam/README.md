**IAM best Practice**

## Purpose

Set up a separate AWS account to manage IAM users - this repo calls this account Admin. 
[This article](https://hackernoon.com/terraform-with-aws-assume-role-21567505ea98) does a good job of explaining why (only we call the ops account "admin")

Each user only has permissions to:
* Change their password
* Add and remove an MFA device from their account
* Generate and delete access keys

Further permissions are added to a role using the [iam-all-accounts](https://github.com/duckalini/my_first_terraform/tree/master/modules/iam-all-accounts) module. There are admin roles with full AWS access, developer roles with read access to Dynamo and S3, and roles for machines. Each role has an assume role policy which specifies who (or what) is allow to assume that role and the associated permissions. All of these roles should exist in all of your AWS accounts - a separate terraform module will set this up.

Assume role policies are two way, the role specifies that the Admin account can delegate access to that role. 


## How

IAM users should be created via the console in the Admin account and can be added to user groups. Each user group is defined in this module, and the roles they can access are added. 
, and then this module should be used to assign them to user groups as needed.

## Usage

This will list off any inputs that are required and whether or not they have a default variable. 

| Variable name | Description | Default Y/N | Default value|
|---------------|-------------|-------------|--------------|
| admin_users | A list of all admin users - this needs to match their IAM user names | N | |
|  developer_users | A list of all admin users - this needs to match their IAM user names | N |  |
