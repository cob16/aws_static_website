terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14.1"
    }
  }
}

resource "aws_budgets_budget" "primary" {
  name              = "monthly-buget"
  budget_type       = "COST"
  limit_amount      = var.billing_alarm_threshold
  limit_unit        = "USD"
  time_period_start = "2020-05-01_00:00"
  time_period_end   = "2087-06-15_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.alert_email]
    subscriber_sns_topic_arns  = [var.over_budget_sns_topic_arn]
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
  }
  notification {
    comparison_operator        = "GREATER_THAN"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.alert_email]
    subscriber_sns_topic_arns  = [var.over_budget_sns_topic_arn]
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
  }
}