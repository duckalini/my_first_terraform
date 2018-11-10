# IAM roles

This module creates all the assume-able roles your users will need in each of your accounts.

**Admin role** - full admin permissions for the associated aws account  
**Developer role** - least privilege permissions, perhaps some read only access to S3  
**Readonly role** - read only access to all the things your using  
**Finance role** - read only access to billing information on each AWS account

This module does not specify who can assume those roles, only that it will be managed by the Admin account in the `iam-admin` module.