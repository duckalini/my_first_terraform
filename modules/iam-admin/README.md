**IAM best Practice**

Set up a separate AWS account to manage IAM users.

Each user only has permissions to:
* Change their password
* Add and remove an MFA device from their account
* Generate and delete access keys


Further permissions are added to a role. There are admin roles with full AWS access, developer roles with read access to Dynamo and S3, and roles for machines. Each role has an assume role policy which specifies who (or what) is allow to assume that role and the associated permissions. All of these roles should exist in all of your AWS accounts - a separate terraform module will set this up.

Assume role policies are two way, the role specifies that the Admin account can delegate access to that role. 

All your users exist in the Admin account and can be added to user groups. Each user group is defined in this module, and the roles they can access are added. 