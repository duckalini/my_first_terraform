# Cloudwatch alarms for Slack Lambda

Create cloudwatch alarms that send messages to slack using the `slack` module.

## To add alarms

Go to the `alarms.tf` file and follow the existing template. The alarm that is currently provisioned is likely to fire once per day.

## Usage
This will list off any inputs that are required and whether or not they have a default variable. 

| Variable name | Description | Default Y/N | Default value|
|---------------|-------------|-------------|--------------|
| environment | Name of your environment, this should be kept short | N | |
| notify_slack_topic_arn | The arn of the slack-lambda SNS topic - format of this should be arn:aws:sns:us-west-2:123456789:slack_notification | N |  |  |
