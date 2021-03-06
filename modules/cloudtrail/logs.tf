resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = "${var.project}-${var.environment}-cloudtrail"
  acl    = "private"

  versioning {
    enabled = true
  }

  // retention policy 30 days
  lifecycle_rule {
    enabled = true

    expiration {
      days = 30
    }
  }
}

// Policy sourced from https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html
data "aws_iam_policy_document" "cloudtrail_logging_bucket_policy" {
  statement {
    sid    = "AWSCloudTrailAclCheck20150319"
    effect = "Allow"

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::${var.project}-${var.environment}-cloudtrail",
    ]

    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }
  }

  statement {
    sid    = "AWSCloudTrailWrite20150319"
    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${var.project}-${var.environment}-cloudtrail/*",
    ]

    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }

    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
  }
}

resource "aws_s3_bucket_policy" "terraform_bucket_delegation" {
  bucket = "${aws_s3_bucket.cloudtrail_logs.id}"
  policy = "${data.aws_iam_policy_document.cloudtrail_logging_bucket_policy.json}"
}

output "logging_bucket_name" {
  value = "${aws_s3_bucket.cloudtrail_logs.id}"
}
