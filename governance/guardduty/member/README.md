# GuardDuty Member

This module creates a GuardDuty detector for account.

## Usage

```hcl
module "guardduty_member" {
  source = "github.com/clalexander/aws-terraform-modules//governance/guardduty/member?ref=v1"

  tags = {
    Name = "GuardDuty Member"
    service-name = "guardduty"
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
| [aws_guardduty_detector.member](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable"></a> [enable](#input\_enable) | Enable GuardDuty | `bool` | `true` | no |
| <a name="input_publishing_frequency"></a> [publishing\_frequency](#input\_publishing\_frequency) | GuardDuty findings publishing frequency. | `string` | `"SIX_HOURS"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all stack resources. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_detector_id"></a> [detector\_id](#output\_detector\_id) | The member ID of the GuardDuty detector. |
<!-- END_TF_DOCS -->
