resource "aws_s3_bucket" "state_file" {
  bucket = "${local.project_name}-${local.environment}"
  acl    = "private"

  versioning {
    enabled = true
  }
}

data "aws_iam_policy_document" "state_file_bucket_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["${aws_s3_bucket.state_file.arn}"]

    principals = [
      {
        type = "AWS"

        identifiers = [
          "arn:aws:iam::${local.admin_account_id}:root",
        ]
      },
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["${aws_s3_bucket.state_file.arn}/*"]

    principals = [
      {
        type = "AWS"

        identifiers = [
          "arn:aws:iam::${local.admin_account_id}:root",
        ]
      },
    ]
  }
}

resource "aws_s3_bucket_policy" "terraform_bucket_delegation" {
  bucket = "${aws_s3_bucket.state_file.id}"
  policy = "${data.aws_iam_policy_document.state_file_bucket_policy.json}"
}
