locals {
  pagerduty_notification = format("PagerDuty,%s", var.pagerduty_integration_id)
  notifications = {
    critical = [local.pagerduty_notification]
    major    = [local.pagerduty_notification]
    minor    = [local.pagerduty_notification]
    warning  = ["Email,docs@example.org"]
    info     = []
  }
}

