resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = "${var.project}-${var.environment}-cloudtrail"
  acl    = "private"

  versioning {
    enabled = true
  }

  // retetion policy 30 days
  lifecycle_rule {
    enabled = true

    expiration {
      days = 30
    }
  }

  // Policy sourced from https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html
  policy = <<POLICY
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "AWSCloudTrailAclCheck20150319",
              "Effect": "Allow",
              "Principal": {"Service": "cloudtrail.amazonaws.com"},
              "Action": "s3:GetBucketAcl",
              "Resource": "arn:aws:s3:::${var.project}-${var.environment}-cloudtrail"
          },
          {
              "Sid": "AWSCloudTrailWrite20150319",
              "Effect": "Allow",
              "Principal": {"Service": "cloudtrail.amazonaws.com"},
              "Action": "s3:PutObject",
              "Resource": "arn:aws:s3:::${var.project}-${var.environment}-cloudtrail/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
              "Condition": {"StringEquals": {"s3:x-amz-acl": "bucket-owner-full-control"}}
          }
      ]
}
POLICY
}

output "logging_bucket_name" {
  value = "${aws_s3_bucket.cloudtrail_logs.id}"
}