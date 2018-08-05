# my-first-terraform  

This project will help show you how to set up Terraform for your AWS environment in a scaleable and maintainable way.  

TODO insert information about conference where this will be presented, hopefully with a link to the recording.


It assumes that you know what Terraform is and why you should use it, but nothing else. 
There are many references to the terraform documentation throughout this project, but most of the basics will be explained as they are used.
Start with the `environments` folder, which contains three seperate environments:

1. 101 get started
2. test
3. production

These should be read in order, as concepts will be built as we go.  

Some configuration will need to be done to make this project work for your own environment and this will be pointed out in the README of each environment. 


#Installing

## Initial terraform setup

Use brew or [follow instructions here](or https://www.terraform.io/downloads.html).

`brew install terraform`  

Downgrading your terraform version on macOS via brew is non trivial.  

Your terraform version is set in your `main.tf` environment file. Everyone working on this project will need to use that version.  
If anyone updates their version and pushes a change, all contributors will need to update their local terraform version. This ensures your state file remains consistent.



## Use aws-vault

TODO Reasons and How To set up go here

[aws-vault](https://github.com/99designs/aws-vault) is a project that allows you to use MFA while using the aws cli. This lets you have mfa when deploying terraform changes.

Install this using the instructions on their project, or the following on MacOS: 

`brew cask install aws-vault`  

Create a config file which contains the following code. Replace the number in `mfa_serial` with your AWS account ID and `duck.lawn` with your IAM user name.  

```
[profile mft]
region=us-west-2
mfa_serial = arn:aws:iam::123456789012:mfa/duck.lawn
```

Then add your aws access tokens to the keychain using these commands:  
```
aws-vault add mft
Enter Acces Key ID:  
Enter Secret Access Key:  
```


## Use terraform plan and apply

Terraform uses a state file to identify differences between what's in your code and what's existing in AWS. Read more detail about them [on the terraform site](https://www.terraform.io/docs/state/purpose.html).  

To start using terraform, you need to run `aws-vault exec mft -- terraform init`. Full details found over on [terraform](https://www.terraform.io/docs/commands/init.html).  
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

This means you're ready to run a plan! If you don't any modules or resources defined (i.e. you only have the first 20 lines of your `main.tf` file defined) this will have no impact on your AWS envionment.

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

If you now run an apply, terraform will generate it's first state file and upload that to S3.  

Specify which plan file you want to apply to ensure no surprise changes are landed.  
```
$ ave mft -- terraform apply plan.out

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

#