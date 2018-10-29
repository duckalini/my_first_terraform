// Enable cloudtrail on your AWS account https://aws.amazon.com/cloudtrail/
// Cloudtrail tracks API calls and creates an auditlog of changes in your AWS account
// Note that this will incur storage charges on your AWS account

resource "aws_cloudtrail" "cloudtrail" {
  name           = "${var.project}-${var.environment}"
  s3_bucket_name = "${aws_s3_bucket.cloudtrail_logs.id}"
}
