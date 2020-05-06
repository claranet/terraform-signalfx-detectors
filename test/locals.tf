locals {
  pagerduty_notification = format("PagerDuty,%s", var.pagerduty_integration_id)
}
