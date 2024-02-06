# SQS Lambda Event Processor

This module creates a Lambda function that processes events from an SQS queue.

## Usage

```hcl
module "sqs_lambda_event_processor" {
  source = "github.com/clalexander/aws-terraform-modules//compute/sqs-lambda-event-processor?ref=v1"

  service_name = "my-service"
  service_env  = "dev"

  lambda_filename = "lambda.zip"
  lambda_handler  = "index.handler"

  events_queue_batch_size         = 10
  events_queue_policy             = data.aws_iam_policy_document.events_queue.json
  events_queue_receive_count      = 1
  events_queue_visibility_timeout = 30
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_service"></a> [service](#module\_service) | terraform-aws-modules/lambda/aws | ~> 6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_lambda_event_source_mapping.events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping) | resource |
| [aws_sqs_queue.deadletter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_events_queue_batch_size"></a> [events\_queue\_batch\_size](#input\_events\_queue\_batch\_size) | (Optional) Number of messages to retrieve from the queue at a time. | `number` | `10` | no |
| <a name="input_events_queue_batch_window"></a> [events\_queue\_batch\_window](#input\_events\_queue\_batch\_window) | (Optional) Maximum amount of time to wait for a full batch before invoking the lambda function, in seconds. | `number` | `null` | no |
| <a name="input_events_queue_maximum_concurrency"></a> [events\_queue\_maximum\_concurrency](#input\_events\_queue\_maximum\_concurrency) | (Optional) Maximum number of concurrent lambda invocations. | `number` | `null` | no |
| <a name="input_events_queue_policy"></a> [events\_queue\_policy](#input\_events\_queue\_policy) | (Optional) Policy to attach to the events queue. | `string` | `null` | no |
| <a name="input_events_queue_receive_count"></a> [events\_queue\_receive\_count](#input\_events\_queue\_receive\_count) | (Optional) Number of times a message can be received before being sent to the dead letter queue. | `number` | `1` | no |
| <a name="input_events_queue_visibility_timeout"></a> [events\_queue\_visibility\_timeout](#input\_events\_queue\_visibility\_timeout) | (Optional) Visibility timeout for the events queue, in seconds. | `number` | `30` | no |
| <a name="input_lambda_description"></a> [lambda\_description](#input\_lambda\_description) | (Optional) Description of the lambda function. | `string` | `null` | no |
| <a name="input_lambda_env_vars"></a> [lambda\_env\_vars](#input\_lambda\_env\_vars) | (Optional) Environment variables to pass to the lambda function. | `map(any)` | `{}` | no |
| <a name="input_lambda_execution_policies"></a> [lambda\_execution\_policies](#input\_lambda\_execution\_policies) | (Optional) List of IAM policies to attach to the lambda function execution role. | `list(string)` | `[]` | no |
| <a name="input_lambda_filename"></a> [lambda\_filename](#input\_lambda\_filename) | Path to the lambda function package. | `string` | n/a | yes |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | Name of the lambda function handler. | `string` | n/a | yes |
| <a name="input_lambda_layers"></a> [lambda\_layers](#input\_lambda\_layers) | (Optional) List of lambda layers to attach to the lambda function. | `list(string)` | `[]` | no |
| <a name="input_lambda_memory_size"></a> [lambda\_memory\_size](#input\_lambda\_memory\_size) | (Optional) Lambda function memory size. | `number` | `128` | no |
| <a name="input_lambda_reserved_concurrent_executions"></a> [lambda\_reserved\_concurrent\_executions](#input\_lambda\_reserved\_concurrent\_executions) | (Optional) Lambda function reserved concurrent executions. | `number` | `null` | no |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | (Optional) Lambda function runtime. | `string` | `"nodejs16.x"` | no |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | (Optional) Lambda function timeout. | `number` | `3` | no |
| <a name="input_log_retention_period"></a> [log\_retention\_period](#input\_log\_retention\_period) | (Optional) Number of days to retain logs in CloudWatch. | `number` | `30` | no |
| <a name="input_service_env"></a> [service\_env](#input\_service\_env) | Environment in which the service is deployed. | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service. | `string` | n/a | yes |
| <a name="input_service_role_name"></a> [service\_role\_name](#input\_service\_role\_name) | (Optional) Role name of the lambda function, overrides the default role name. | `string` | `null` | no |
| <a name="input_service_visibility"></a> [service\_visibility](#input\_service\_visibility) | (Optional) Visibility of the service (public or private). | `string` | `"private"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to apply to all resources. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_events_queue"></a> [events\_queue](#output\_events\_queue) | The SQS queue that receives events from the source. |
<!-- END_TF_DOCS -->
