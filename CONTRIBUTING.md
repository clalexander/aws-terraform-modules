# Contributing

## Documentation

This repository uses [terraform-docs](https://terraform-docs.io/user-guide/introduction/) to generate documentation for each module.  The documentation is generated from the `README.md` file in each module directory.  The documentation is generated using the following command:

```bash
terraform-docs markdown table <path/to/module>
```

**Note:** The `terraform-docs` command must be run from the root of the repository.

## Pull Requests

All changes must be added via a pull request.

1. Fork the repository
1. Create a new branch
1. Make your changes
1. Add documentation for your changes
1. Validate, lint, and format your changes
1. Push your changes to your fork
1. Submit a pull request
1. Grab a cup of coffee and wait for your pull request to be reviewed and merged

The following checks will be performed on all pull requests:

### Validation

Be sure to validate your changes with the following command:

```bash
terraform validate
```

### Linting

All modules must be linted with [`tflint`](https://github.com/terraform-linters/tflint) to ensure that all modules follow best practices.  The linting is applied using the following command:

```bash
tflint --init
tflint
```

### Formatting

All modules must be formatted with [`terraform fmt`](https://www.terraform.io/docs/commands/fmt.html) to format all Terraform code.  The formatting is applied using the following command:

```bash
terraform fmt -recursive
```
