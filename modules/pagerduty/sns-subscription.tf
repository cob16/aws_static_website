resource "aws_sns_topic_subscription" "this" {
  protocol               = "https"
  topic_arn              = var.sns_topic
  endpoint               = "https://events.pagerduty.com/integration/${pagerduty_service_integration.aws-cw.integration_key}/enqueue"
  endpoint_auto_confirms = true
}