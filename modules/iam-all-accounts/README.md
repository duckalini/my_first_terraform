# IAM roles

## Purpose
This module creates all the assume-able roles your users will need in each of your accounts. It should be added to every environment.

**Admin role** - full admin permissions for the associated aws account  
**Developer role** - least privilege permissions, perhaps some read only access to S3  
**Readonly role** - read only access to all the things your using  
**Finance role** - read only access to billing information on each AWS account

This module does not specify who can assume those roles, only that it will be managed by the Admin account in the `iam-admin` module.


## Usage
This will list off any inputs that are required and whether or not they have a default variable. 

| Variable name | Description | Default Y/N | Default value|
|---------------|-------------|-------------|--------------|
| environment | Name of your environment, this should be kept short | N/A | |
|  region | AWS region your resources should be created in  | Y | us-west-2 |
