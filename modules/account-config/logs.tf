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

  policy = <<POLICY
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "AWSCloudTrailAclCheck20150319",
              "Effect": "Allow",
              "Principal": {"Service": "cloudtrail.amazonaws.com"},
              "Action": "s3:GetBucketAcl",
              "Resource": "arn:aws:s3:::myBucketName"
          },
          {
              "Sid": "AWSCloudTrailWrite20150319",
              "Effect": "Allow",
              "Principal": {"Service": "cloudtrail.amazonaws.com"},
              "Action": "s3:PutObject",
              "Resource": "arn:aws:s3:::myBucketName/[optional prefix]/AWSLogs/myAccountID/*",
              "Condition": {"StringEquals": {"s3:x-amz-acl": "bucket-owner-full-control"}}
          }
      ]
  }
POLICY
}

output "logging_bucket_name" {
  value = "${aws_s3_bucket.cloudtrail_logs.id}"
}