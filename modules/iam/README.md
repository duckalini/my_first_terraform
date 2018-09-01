# IAM users

[IAM users](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html) need to be created manually via the console and then added to the appropriate groups.

(Do we want to Terraform adding them to groups? We can, that'd be a pretty easy addition... may add it later)

## IAM groups

Each IAM group allows the users in it to assume roles to get permissions. IAM users themselves only have base user permissions assigned - making them able to login, change their password and enable MFA. 
IAM users can only assume roles if they have MFA enabled. Warning that users must log out and back in after enabling MFA before they will be able to assume a role.

# IAM infrastructure

Most infrastructure IAM roles should be defined within the module that uses them. That will ensure this module does not grow too large.

However, any service level roles for logging or metrics should be defined in here.  

