data "aws_caller_identity" "current" {}

# Recorder-status is used to actually start the recorder
resource "aws_config_configuration_recorder_status" "recorder_status" {
  name       = aws_config_configuration_recorder.recorder.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.config_delivery]
}

resource "aws_config_configuration_recorder" "recorder" {
  name     = var.configuration_recorder_name
  role_arn = aws_iam_service_linked_role.config.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

# Config delivery once per hour
resource "aws_config_delivery_channel" "config_delivery" {
  name           = var.delivery_channel_name
  s3_bucket_name = aws_s3_bucket.bucket.bucket
  depends_on     = [aws_config_configuration_recorder.recorder]

  snapshot_delivery_properties {
    delivery_frequency = var.delivery_frequency
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = merge(var.tags, { "Name" = var.bucket_name })
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

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AWSConfigBucketPermissionsCheck",
        "Effect": "Allow",
        "Principal": {
          "Service": [
           "config.amazonaws.com"
          ]
        },
        "Action": "s3:GetBucketAcl",
        "Resource": "arn:aws:s3:::${var.bucket_name}"
      },
      {
        "Sid": " AWSConfigBucketDelivery",
        "Effect": "Allow",
        "Principal": {
          "Service": [
           "config.amazonaws.com"
          ]
        },
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::${var.bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/Config/*",
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
