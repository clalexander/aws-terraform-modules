variable "cloudtrail_sns_topic_name" {
  description = "Name of the SNS topic to send CloudTrail alarms to."
  type        = string
  default     = null
}

variable "cloudtrail_sns_topic_arn" {
  description = "ARN of the SNS topic to send CloudTrail alarms to."
  type        = string
  default     = null
}

variable "cloudtrail_log_group_name" {
  description = "Name of the CloudTrail log group."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources."
  default     = {}
  type        = map(any)
}
