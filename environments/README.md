# Initial terraform setup

`brew install terraform`  

Downgrading your terraform version on macOS via brew is non trivial.  
Note your terraform version and set it in your main file (under environments). Everyone working on this project will need to use that version.  
If anyone updates their version and pushes a change, all contributors will need to update their local terraform version. This ensures your state file remains consistent.


# Use aws-vault

TODO Reasons and How To set up go here

`brew install awsvault` ?? confirm ??

Create a config file

```
[profile mft]
region=us-west-2
mfa_serial = arn:aws:iam::123456789012:mfa/duck.lawn

[profile mft-admin]
region=us-west-2
role=arn:aws:iam::123456789012:role/admin
mfa_serial = arn:aws:iam::123456789012:mfa/duck.lawn

[profile mft-dev]
region=us-west-2
role=arn:aws:iam::123456789012:role/dev
mfa_serial = arn:aws:iam::123456789012:mfa/duck.lawn
```
