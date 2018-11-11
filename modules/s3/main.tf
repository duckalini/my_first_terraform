resource "aws_s3_bucket" "user_upload_bucket" {
    bucket = "${var.environment}-upload-bucket"
    acl = "private"

    policy = "${aws_iam_policy.bucket_policy.arn}"
}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${var.environment}-upload-bucket",
    ]
  }
}

resource "aws_iam_policy" "bucket_policy" {
  name   = "s3_bucket_policy"
  path   = "/"
  policy = "${data.aws_iam_policy_document.s3_bucket_policy.json}"
}