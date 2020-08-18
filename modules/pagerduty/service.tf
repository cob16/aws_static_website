data "pagerduty_escalation_policy" "default" {
  name = "Default"
}

resource "pagerduty_service" "website" {
  name              = var.website_name
  description       = "cloudwatch alerts for ${var.website_name}"
  escalation_policy = data.pagerduty_escalation_policy.default.id
  alert_creation    = "create_alerts_and_incidents"

  acknowledgement_timeout = "null"
  auto_resolve_timeout    = "null"
}

data "pagerduty_vendor" "cloudwatch" {
  name = "Cloudwatch"
}

resource "pagerduty_service_integration" "aws-cw" {
  name    = data.pagerduty_vendor.cloudwatch.name
  vendor  = data.pagerduty_vendor.cloudwatch.id
  service = pagerduty_service.website.id
}