# Modules

Modules are reusable chunks of code - used as building blocks to create and configure your environments. 

Modules are made up of variables, resources, data and outputs. 

**Variables** are inputs - which can have default values and be overridden by whatever you pass in. You can use these variables to create unique resource names or configure different environments with the same module.
Modules can also return **outputs** which can then be passed over to other modules. Terraform tracks dependencies, so it’ll know what order to create things (it does error if there’s a cyclic dependency).

**Resources** are things in AWS, like S3 buckets or IAM polices. They are artifacts in AWS and can be configured. You can find all the different types of resources and their configuration options for AWS at https://www.terraform.io/docs/providers/aws/r/s3_bucket.html  
Read about configuring resources in general at https://www.terraform.io/docs/configuration/resources.html 

**Data** allow you to utilise local things like files and pass them in to terraform. You can read more at https://www.terraform.io/docs/configuration/data-sources.html

## Using these modules

Each module should have the following sections laid out in a README file.

### Purpose
This is a short description of what the modules achieves and why that is useful.

### Usage
This will list off any inputs that are required and whether or not they have a default variable. 

| Variable name | Description | Default Y/N | Default value|
|---------------|-------------|-------------|--------------|
| environment | Name of your environment, this should be kept short | N | |
|  region | AWS region your resources should be created in  | Y | us-west-2 |
