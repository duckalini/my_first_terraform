# Cloudtrail

## Purpose
Configure cloudtrail to ensure all infrastructure changes are logged and auditable. This will allow you to trace changes back to individual users.  
Cloudtrail will log this back to an S3 bucket.

### Usage
This will list off any inputs that are required and whether or not they have a default variable. 

| Variable name | Description | Default Y/N | Default value|
|---------------|-------------|-------------|--------------|
| environment | Name of your environment, this should be kept short | N | |
| project | A unique project name, used to create unique resource names in AWS. i.e. Company name  | N |  |
