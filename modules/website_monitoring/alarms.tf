variable "estimated_billing_threshold" {
  description = "the cost in $ of when to fire an alert"
  type        = number
  default     = 2
}

resource "aws_cloudwatch_metric_alarm" "six-hour-billing-warning" {
  alarm_name          = "High Billing Estimate"
  comparison_operator = "GreaterThanThreshold"
  threshold           = var.estimated_billing_threshold

  datapoints_to_alarm = 1
  evaluation_periods  = 1
  period              = 21600 //billing metrics are only calculated every 6 hours, reducing this number will have no effect
  statistic           = "Maximum"
  treat_missing_data  = "breaching"

  namespace   = "AWS/Billing"
  metric_name = "EstimatedCharges"
  dimensions = {
    Currency = "USD"
  }


  alarm_actions = [
    var.cloudwatch_general_alarm_sns_arn
  ]
  ok_actions = [
    var.cloudwatch_general_alarm_sns_arn
  ]

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "cloudfront-free-tier-limit" {
  alarm_name          = "Cloudfront free requests limit"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 66000 //2 million requests per month on the free tear, devided over 30 days

  datapoints_to_alarm = 1
  evaluation_periods  = 1
  period              = 86400
  statistic           = "Sum"
  treat_missing_data  = "missing"

  namespace   = "AWS/CloudFront"
  metric_name = "Requests"
  dimensions = {
    DistributionId = var.distribution_id
    Region         = "Global"
  }


  alarm_actions = [
    var.cloudwatch_general_alarm_sns_arn
  ]
  ok_actions = [
    var.cloudwatch_general_alarm_sns_arn
  ]

  tags = var.tags
}
