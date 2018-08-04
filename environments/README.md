# Initial terraform setup

`brew install terraform`  

Downgrading your terraform version on macOS via brew is non trivial.  

Note your terraform version and set it in your main file (under environments). Everyone working on this project will need to use that version.  
If anyone updates their version and pushes a change, all contributors will need to update their local terraform version. This ensures your state file remains consistent.



# Use aws-vault

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


# Use terraform plan and apply

