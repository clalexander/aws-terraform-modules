data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_cloudtrail" "trail" {
  name                          = var.name
  s3_bucket_name                = aws_s3_bucket.bucket.bucket
  s3_key_prefix                 = ""
  kms_key_id                    = aws_kms_key.cloudtrail.arn
  enable_log_file_validation    = var.enable_log_file_validation
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail.arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"

  tags = merge(var.tags, { "Name" = var.name })
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = merge(var.tags, { "Name" = var.name })
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"

  depends_on = [aws_s3_bucket_ownership_controls.this]
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<POLICY
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "AWSCloudTrailAclCheck",
              "Effect": "Allow",
              "Principal": {
                  "Service": "cloudtrail.amazonaws.com"
              },
              "Action": "s3:GetBucketAcl",
              "Resource": "arn:aws:s3:::${var.bucket_name}"
          },
          {
              "Sid": "AWSCloudTrailWrite",
              "Effect": "Allow",
              "Principal": {
                  "Service": "cloudtrail.amazonaws.com"
              },
              "Action": "s3:PutObject",
              "Resource": "arn:aws:s3:::${var.bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}*",
              "Condition": {
                  "StringEquals": {
                      "s3:x-amz-acl": "bucket-owner-full-control"
                  }
              }
          }
      ]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = var.name
  retention_in_days = var.retention_in_days

  tags = merge(var.tags, { "Name" = var.name })
}
