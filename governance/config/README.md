# Config

Enables AWS Config recording for the account.

## Usage

```hcl
module "config" {
  // HERE update the module source
  source = "github.com/blackglove/terraform-modules//governance/config?ref=v1.0.0"

  bucket_name = "bucket-name"

  tags = {
    Name = "Black Glove Config"
    service-name = "config"
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
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_config_configuration_recorder.recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder) | resource |
| [aws_config_configuration_recorder_status.recorder_status](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder_status) | resource |
| [aws_config_delivery_channel.config_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_delivery_channel) | resource |
| [aws_iam_service_linked_role.config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | S3 Config bucket name.  Recommend config-ACCOUNT\_ID. | `string` | n/a | yes |
| <a name="input_configuration_recorder_name"></a> [configuration\_recorder\_name](#input\_configuration\_recorder\_name) | Name for the configuration recorder.  Only visible via API. | `string` | `"config-recorder"` | no |
| <a name="input_delivery_channel_name"></a> [delivery\_channel\_name](#input\_delivery\_channel\_name) | Name for the delivery channel.  Only visible via API. | `string` | `"config-delivery"` | no |
| <a name="input_delivery_frequency"></a> [delivery\_frequency](#input\_delivery\_frequency) | Config snapshot delivery frequency. | `string` | `"One_Hour"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all stack resources. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_role_arn"></a> [config\_role\_arn](#output\_config\_role\_arn) | Config service-linked role ARN. |
<!-- END_TF_DOCS -->
