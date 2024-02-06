variable "service_name" {
  description = "Name of the service."
  type        = string
}

variable "service_env" {
  description = "Environment in which the service is deployed."
  type        = string
}

variable "service_visibility" {
  description = "(Optional) Visibility of the service (public or private)."
  type        = string
  default     = "private"
}

variable "service_role_name" {
  description = "(Optional) Role name of the lambda function, overrides the default role name."
  type        = string
  default     = null
}

variable "events_queue_visibility_timeout" {
  description = "(Optional) Visibility timeout for the events queue, in seconds."
  type        = number
  default     = 30
}

variable "events_queue_receive_count" {
  description = "(Optional) Number of times a message can be received before being sent to the dead letter queue."
  type        = number
  default     = 1
}

variable "events_queue_batch_size" {
  description = "(Optional) Number of messages to retrieve from the queue at a time."
  type        = number
  default     = 10
}

variable "events_queue_maximum_concurrency" {
  description = "(Optional) Maximum number of concurrent lambda invocations."
  type        = number
  default     = null
}

variable "events_queue_batch_window" {
  description = "(Optional) Maximum amount of time to wait for a full batch before invoking the lambda function, in seconds."
  type        = number
  default     = null
}

variable "events_queue_policy" {
  description = "(Optional) Policy to attach to the events queue."
  type        = string
  default     = null
}

variable "lambda_filename" {
  description = "Path to the lambda function package."
  type        = string
}

variable "lambda_handler" {
  description = "Name of the lambda function handler."
  type        = string
}

variable "lambda_description" {
  description = "(Optional) Description of the lambda function."
  type        = string
  default     = null
}

variable "lambda_env_vars" {
  description = "(Optional) Environment variables to pass to the lambda function."
  type        = map(any)
  default     = {}
}

variable "lambda_layers" {
  description = "(Optional) List of lambda layers to attach to the lambda function."
  type        = list(string)
  default     = []
}

variable "lambda_execution_policies" {
  description = "(Optional) List of IAM policies to attach to the lambda function execution role."
  type        = list(string)
  default     = []
}

variable "lambda_runtime" {
  description = "(Optional) Lambda function runtime."
  type        = string
  default     = "nodejs16.x"
}

variable "lambda_memory_size" {
  description = "(Optional) Lambda function memory size."
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "(Optional) Lambda function timeout."
  type        = number
  default     = 3
}

variable "lambda_reserved_concurrent_executions" {
  description = "(Optional) Lambda function reserved concurrent executions."
  type        = number
  default     = null
}

variable "log_retention_period" {
  description = "(Optional) Number of days to retain logs in CloudWatch."
  type        = number
  default     = 30
}

variable "tags" {
  description = "(Optional) Tags to apply to all resources."
  type        = map(any)
  default     = {}
}
