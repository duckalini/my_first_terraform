# Notify Slack Lambda

Sourced and modified from https://github.com/terraform-aws-modules/terraform-aws-notify-slack

This Lambda sends Cloudwatch event alarms to a specified Slack channel.

## To set up

Login to the AWS console and navigate to EC2. Down the bottom left of the screen, you can navigate to SYSTEMS MANAGER SHARED RESOURCES, Parameter Store.  
Create a secure string Parameter which contains your Slack Webhook. This encrypts your webhook using KMS so that it is never stored in plaintext in AWS.
Use path based notation for your Parameter name i.e. `/$environment/lambda/slack_webhook_url`. You will need to pass this in as a variable to this module. Path based names allow you to apply granular permissions to parameter store access.

## To use