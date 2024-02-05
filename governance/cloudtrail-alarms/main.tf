data "aws_sns_topic" "cloudtrail_alarms" {
  count = var.cloudtrail_sns_topic_name != null ? 1 : 0

  name = var.cloudtrail_sns_topic_name
}

locals {
  cloudtrail_sns_topic_arn = coalesce(
    var.cloudtrail_sns_topic_arn,
    try(data.aws_sns_topic.cloudtrail_alarms[0].arn, null),
  )
}

module "cloudtrail_alarms" {
  source  = "trussworks/cloudtrail-alarms/aws"
  version = "~> 2.2.0"

  alarm_prefix = "CloudTrail"

  alarm_sns_topic_arn       = local.cloudtrail_sns_topic_arn
  cloudtrail_log_group_name = var.cloudtrail_log_group_name

  tags = var.tags
}
