# SNS Module

## Purpose

Creates an Amazon SNS topic for infrastructure monitoring alerts.

## Resources Created

- SNS Topic
- Email Subscription

## Inputs

| Variable | Description |
|----------|-------------|
| project_name | Project name |
| environment | Environment (prod/dev) |
| notification_email | Email to receive alerts |

## Outputs

| Output | Description |
|--------|-------------|
| topic_arn | ARN of the SNS topic |
| topic_name | Name of the SNS topic |

## Example

```hcl
module "sns" {
  source = "../../modules/sns"

  project_name      = var.project_name
  environment       = var.environment
  notification_email = var.notification_email
}
```
