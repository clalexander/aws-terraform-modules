locals {
  deadletter_sqs_name = "${var.service_name}__deadletter"
  default_env_vars = {
    SERVICE_ENV = var.service_env
  }
  env_vars = merge(local.default_env_vars, var.lambda_env_vars)
  default_tags = {
    Name               = var.service_name
    service-name       = var.service_name
    service-visibility = var.service_visibility
    service-env        = var.service_env
  }
  tags = merge(local.default_tags, var.tags)
}

resource "aws_sqs_queue" "events" {
  name = var.service_name

  policy = var.events_queue_policy

  visibility_timeout_seconds = var.events_queue_visibility_timeout

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter.arn
    maxReceiveCount     = var.events_queue_receive_count
  })

  tags = local.tags
}

resource "aws_sqs_queue" "deadletter" {
  name = local.deadletter_sqs_name

  tags = local.tags
}

locals {
  lambda_execution_policy = templatefile("${path.module}/policies/lambda-execution-policy.json", {
    EVENTS_QUEUE_ARN     = aws_sqs_queue.events.arn
    DEADLETTER_QUEUE_ARN = aws_sqs_queue.deadletter.arn
  })
}

module "service" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = var.service_name
  role_name     = var.service_role_name
  description   = var.lambda_description

  create_package         = false
  local_existing_package = var.lambda_filename
  handler                = var.lambda_handler
  layers                 = var.lambda_layers
  environment_variables  = local.env_vars

  runtime                        = var.lambda_runtime
  memory_size                    = var.lambda_memory_size
  timeout                        = var.lambda_timeout
  reserved_concurrent_executions = var.lambda_reserved_concurrent_executions

  attach_dead_letter_policy = true
  dead_letter_target_arn    = aws_sqs_queue.deadletter.arn

  # TODO: re add these when putting into a VPC
  # vpc_subnet_ids = var.vpc_subnet_ids
  # vpc_security_group_ids = var.vpc_security_group_ids

  attach_policy_json = true
  policy_json        = local.lambda_execution_policy

  attach_policy_jsons    = true
  policy_jsons           = var.lambda_execution_policies
  number_of_policy_jsons = length(var.lambda_execution_policies)

  cloudwatch_logs_retention_in_days = var.log_retention_period

  ## manual event source mapping until terraform-aws-modules/lambda/aws updated to include maximum_concurrency
  ## TODO: re add this when terraform-aws-modules/lambda/aws updated to include maximum_concurrency
  # event_source_mapping = {
  #   sqs = {
  #     event_source_arn = aws_sqs_queue.events.arn
  #     batch_size = var.events_queue_batch_size
  #     maximum_batching_window_in_seconds = var.events_queue_batch_window
  #     function_response_types = [
  #       "ReportBatchItemFailures"
  #     ]
  #   }
  # }

  tags = var.tags

}

resource "aws_lambda_event_source_mapping" "events" {
  event_source_arn = aws_sqs_queue.events.arn
  function_name    = module.service.lambda_function_arn

  batch_size                         = var.events_queue_batch_size
  maximum_batching_window_in_seconds = var.events_queue_batch_window

  dynamic "scaling_config" {
    for_each = var.events_queue_maximum_concurrency == null ? [] : [1]
    content {
      maximum_concurrency = var.events_queue_maximum_concurrency
    }
  }

  function_response_types = [
    "ReportBatchItemFailures"
  ]
}
