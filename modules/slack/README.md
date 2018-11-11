# Notify Slack Lambda

Allow cloudwatch events to trigger a lambda and post a summary in to a slack channel.
Sourced and modified from https://github.com/terraform-aws-modules/terraform-aws-notify-slack

## To set up

Login to the AWS console and navigate to EC2. Down the bottom left of the screen, you can navigate to SYSTEMS MANAGER SHARED RESOURCES, Parameter Store.  
Create a secure string Parameter which contains your Slack Webhook. This encrypts your webhook using KMS so that it is never stored in plaintext in AWS.
Use path based notation for your Parameter name i.e. `/$environment/lambda/slack_webhook_url`. You will need to pass this in as a variable to this module. Path based names allow you to apply granular permissions for who can access parameter store entries.

## Usage
This will list off any inputs that are required and whether or not they have a default variable. 

| Variable name | Description | Default Y/N | Default value|
|---------------|-------------|-------------|--------------|
| lambda_function_name | The name of the Lambda function to create | Y | notify_slack |
| slack_webhook_url_ssm_path | The SSM paramether path to the URL of Slack webhook | N |  |
| slack_channel | The name of the channel in Slack for notifications (including the #) | N |  |
| slack_username | The username that will appear on Slack messages | N |  |
| slack_emoji | A custom emoji that will appear on Slack messages - including the `::` | Y | :aws: |
|  |  |  |  |