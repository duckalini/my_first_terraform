
// Grants permissions for users to... change password, add and remove ssh keys, access tokens and MFA devices for their own user only.

// self_managed_iam_user

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:ChangePassword",
                "iam:*LoginProfile",
                "iam:*AccessKey*",
                "iam:*SSHPublicKey*"
            ],
            "Resource": [
                "arn:aws:iam::*:user/${aws:username}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
            "iam:CreateVirtualMFADevice",
            "iam:EnableMFADevice",
            "iam:ResyncMFADevice",
            "iam:DeleteVirtualMFADevice"
            ],
            "Resource":  [
                "arn:aws:iam::account-id-without-hyphens:mfa/${aws:username}",
                "arn:aws:iam::account-id-without-hyphens:user/${aws:username}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetAccountPasswordPolicy"
            ],
            "Resource": "*"
        }
    ]
}