# my-first-terraform  

This project will help show you how to set up terraform for your aws environment in a scaleable and maintainable way.  
It was presented at Purplecon 2018, on Thursday November 15th and you can watch the recording of that [on YouTube](https://www.youtube.com/watch?v=syK_Y9gQQu4).

This project assumes that you know what terraform is and why you should use it, but nothing else. The talk referenced above explains a little bit about:
* The benefits of using terraform for your infrastructure as code
* How terraform tracks what has been deployed to AWS using a remote statefile
* How terraform uses a `plan` to run a diff between your code and your AWS account, and how you use that to `apply` changes.
The slides for this talk have been published <link tbc>.

There are many references to the terraform documentation throughout this project, but most of the basics will be explained as they are used.
Start with the `environments` folder, which contains three separate environments:

1. 101 get started
2. test
3. admin

These should be read in order, as concepts will be built upon as we go.  

Some configuration will need to be done to make this project work for your own environment and this will be pointed out in the README of each environment. 


# Manual configuration of your AWS account required

## Initial user set up on AWS
Use your root account to create an IAM user with admin permissions. You can follow the [instructions provided by AWS to do this](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console).  

Your user will need `Programmatic access` only for now. When you get to the Set Permissions page, choose `Attach existing policies to user directly` and use the `Administrator` permissions policy. We will terraform this later. You don't need to set a permissions boundary.

Save your password to your password manager of choice, and then log out of the root account. Log back in using your new IAM user and [add MFA following these instructions](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_enable_virtual.html).

# Set up local computer for development

Things you need before you go read `101 getting started`

## Install terraform

Use brew or [follow instructions here](https://www.terraform.io/downloads.html).

`brew install terraform`  

Ensure you get the latest version of terraform.  

Your terraform version is set in your `main.tf` file for each environment. Each individual contributor working on your terraform project will need to use that version locally.  
If anyone updates their version and pushes a change, all contributors will need to update their local terraform version to match.

Downgrading your terraform version on macOS via brew is non trivial, so try get everyone installing and updating at the same time.


## Install and set up aws-vault

[aws-vault](https://github.com/99designs/aws-vault) is a project that allows you to assume roles and use MFA when using the aws cli or applying terraform changes. 

Install this using the instructions on their project, or the following on MacOS: 

`brew cask install aws-vault`  

Log in to AWS and go to your IAM user. Generate an access key [following these instructions](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey).

Then add your new access key ID and secret to the keychain (via aws-vault) using these commands:  
```
aws-vault add mft
Enter Acces Key ID:  
Enter Secret Access Key:  
```

Update your config file `~/.aws/config` to add your MFA details. Replace the `123456789` in **mfa_serial** with your AWS account ID and `duck.lawn` with your IAM user name.  

```
[profile mft]
region=us-west-2
mfa_serial = arn:aws:iam::123456789012:mfa/duck.lawn
```

To assume roles, you'll need to add more profiles to your config file. This specifies the **source_profile** (ie. access keys used) to assume the role and the **role_arn** of the role you will be assuming.  
It'll look something like this when you're done...
```
[profile mft]
region=us-west-2
mfa_serial = arn:aws:iam::123456789012:mfa/duck.lawn

[profile mft-admin-admin]
region=us-west-2
source_profile=mft
mfa_serial=arn:aws:iam::123456789012:mfa/duck.lawn
role_arn=arn:aws:iam::123456789012:role/admin

[profile mft-test-admin]
region=us-west-2
source_profile=mft
mfa_serial=arn:aws:iam::123456789012:mfa/duck.lawn
role_arn=arn:aws:iam::987654321:role/admin
```


## Use terraform 

Terraform uses a state file to identify differences between what's in your code and what's existing in AWS. Read more detail about them [on the terraform site](https://www.terraform.io/docs/state/purpose.html).  

### terraform init 

To start using terraform, you need to run `aws-vault exec mft-admin-admin -- terraform init` while in your environment directory. Full details found over on [terraform](https://www.terraform.io/docs/commands/init.html).  
The TLDR version is that this ensures you have access to your remote state file, have the correct aws provider version and all your modules are downloaded / "compiled".

Once this has completed (if you have no modules to initialise) you will see something like this:
```
$ ave mft -- terraform init

Initializing the backend...

Initializing provider plugins...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### terraform plan

This means you're ready to run a plan! If you don't have any modules or resources defined (i.e. you only have the first 20 lines of your `main.tf` file defined) this will have no impact on your AWS environment.

A plan will tell you everything that terraform wants to change in your environment. Usually it will end with a line that says `Plan: 2 to add, 1 to change, 1 to destroy` depending on what you've altered.  
It will also print out every single change it will make in full.  

Always use the `-out` option. This will send your plan to a local file.  
```
ave mft -- terraform plan -out=plan.out
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed.
```

Because our infrastructure only has the provider versions and the state file lcoation declared, there's no changes that will be made.

### terraform apply

If you now run an apply, terraform will generate it's first state file and upload that to S3.  

Specify which plan file you want to apply to ensure no surprise changes are landed.  
```
$ ave mft -- terraform apply plan.out

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

## Install and set up terraform landscape

[Terraform landscape](https://github.com/coinbase/terraform-landscape) cleans up the output of a terraform plan.  

This is particularly useful when checking the diff between IAM policy documents. Terraform is notoriously bad at formatting these in a human-readable way. Landscape will fix that for you and highlight specific changes and hide anything that isn't changing allowing you to catch unexpected changes before they're applied.

Use `terraform plan -out=plan.out | tee /dev/tty | landscape` to pass plan files to landscape for formatting.
