# CloudTrail Alarms

Creates CloudWatch alarms for CloudTrail events.

## Usage

```hcl
module "cloudtrail_alarms" {
  // HERE update the module source
  source = "github.com/blackglove/terraform-modules//governance/cloudtrail-alarms?ref=v1.0.0"

  cloudtrail_log_group_name = "/aws/cloudtrail/my-cloudtrail"
  cloudtrail_sns_topic_name = "my-cloudtrail-alarms"

  tags = {
    Name = "Black Glove CloudTrail Alarms"
    service-name = "cloudtrail"
    service-visibility = "private"
    service-env = "shared"
  }
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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.16.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudtrail_alarms"></a> [cloudtrail\_alarms](#module\_cloudtrail\_alarms) | trussworks/cloudtrail-alarms/aws | ~> 2.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic.cloudtrail_alarms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudtrail_log_group_name"></a> [cloudtrail\_log\_group\_name](#input\_cloudtrail\_log\_group\_name) | Name of the CloudTrail log group. | `string` | n/a | yes |
| <a name="input_cloudtrail_sns_topic_arn"></a> [cloudtrail\_sns\_topic\_arn](#input\_cloudtrail\_sns\_topic\_arn) | ARN of the SNS topic to send CloudTrail alarms to. | `string` | `null` | no |
| <a name="input_cloudtrail_sns_topic_name"></a> [cloudtrail\_sns\_topic\_name](#input\_cloudtrail\_sns\_topic\_name) | Name of the SNS topic to send CloudTrail alarms to. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources. | `map(any)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
