locals {
  bucket_name = ["${var.environment}-upload-bucket"]
}

resource "aws_s3_bucket" "user_upload_bucket" {
    bucket = ["${local.bucket_name}"]
    acl = "private"

    policy = "${aws_iam_policy.bucket_policy}"
}

data "aws_iam_policy_document" "s3_bucket_policy" {

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_name}"
    ]
  }
}

resource "aws_iam_policy" "bucket_policy" {
  name   = "s3_bucket_policy"
  path   = "/"
  policy = "${data.aws_iam_policy_document.s3_bucket_policy.json}"
}