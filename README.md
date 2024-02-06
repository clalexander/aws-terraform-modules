# AWS Terraform Modules

This repository contains Terraform modules for common infrastructure patterns.

## Modules

### Goverance

- [CloudTrail Alarms](./governance/cloudtrail-alarms/README.md)
- [CloudTrail](./governance/cloudtrail/README.md)
- [Config](./governance/config/README.md)
- [GuardDuty Member](./governance/guardduty/member/README.md)

### Compute

- [SQS Lambda Event Processor](./compute/sqs-lambda-event-processor/README.md)

## Usage

```hcl
module "module_name" {
  source = "git@github.com:clalexander/aws-terraform-modules.git//path/to/module"
  
  variable1 = "value1"
  variable2 = "value2"
}

# Example
module "guardduty_member" {
  source = "git@github.com:clalexander/aws-terraform-modules.git//governance/guardduty/member?ref=v1"

  tags = {
    Name = "Guardduty Member"
    service-name = "guardduty"
    service-visibility = "private"
    service-env = "shared"
  }
}
```
