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

## Contribution

### Documentation

This repository uses [terraform-docs](https://terraform-docs.io/user-guide/introduction/) to generate documentation for each module.  The documentation is generated from the `README.md` file in each module directory.  The documentation is generated using the following command:

```bash
terraform-docs markdown table <path/to/module>
```

**Note:** The `terraform-docs` command must be run from the root of the repository.

### Pull Requests

All changes must be added via a pull request, and the following checks will be performed on all pull requests:

#### Validation

Be sure to validate your changes with the following command:

```bash
terraform validate
```

#### Linting

All modules must be linted with [`tflint`](https://github.com/terraform-linters/tflint) to ensure that all modules follow best practices.  The linting is applied using the following command:

```bash
tflint --init
tflint
```

#### Formatting

All modules must be formatted with [`terraform fmt`](https://www.terraform.io/docs/commands/fmt.html) to format all Terraform code.  The formatting is applied using the following command:

```bash
terraform fmt -recursive
```
