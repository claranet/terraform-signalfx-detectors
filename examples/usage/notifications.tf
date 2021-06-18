# Define a global recipient of email type manually for low priority alerts
variable "global_recipient" {
  description = "Recipient assigned globally to every notifications severity rules"
  type = object({
    type = string
    args = string
  })
  default = {
    type = "Email"
    args = "doc@signalfx.null"
  }
}

# Configure Slack integration for medium priority alerts
module "signalfx-integrations-alerting-slack" {
  source             = "github.com/claranet/terraform-signalfx-integrations.git//alerting/slack?ref=v0.3.0"
  webhook_url        = var.slack_webhook_url
  slack_channel_name = var.slack_channel_name
}

# Configure PagerDuty integration for high priority alerts and oncall handling business hours only
module "signalfx-integrations-alerting-pagerduty-bh" {
  source  = "github.com/claranet/terraform-signalfx-integrations.git//alerting/pagerduty?ref=v0.3.0"
  api_key = var.pagerduty_token_bh
  suffix  = var.client_name
}

# Configure PagerDuty integration for high priority alerts and oncall handling h24
module "signalfx-integrations-alerting-pagerduty-nbh" {
  source  = "github.com/claranet/terraform-signalfx-integrations.git//alerting/pagerduty?ref=v0.3.0"
  api_key = var.pagerduty_token_nbh
  suffix  = var.client_name
}

locals {
  # Format the `global_recipient` to follow the notification format: "Email,doc@signalfx.null"
  notification_global = format("%s,%s", var.global_recipient.type, var.global_recipient.args)
  # Bind destinations list per severity which will be used globally for all detectors
  notifications = {
    # Critical alerts are for oncall so we use PagerDuty
    critical = [local.notification_global, module.signalfx-integrations-alerting-pagerduty-nbh.sfx_integration_notification]
    # Major alerts are also important but we only want to warn oncall during business hours
    major    = [local.notification_global, module.signalfx-integrations-alerting-pagerduty-bh.sfx_integration_notification]
    # Minor alerts are should not be disruptive and can be handled when we have time so we use Slack
    minor    = [local.notification_global, module.signalfx-integrations-alerting-slack.sfx_integration_notification]
    # Same as for minor
    warning  = [local.notification_global, module.signalfx-integrations-alerting-slack.sfx_integration_notification]
    # And finally, info are only sent to your global email recipient
    info     = [local.notification_global]
  }
}

# Now we can import again a module and simply use this local for global notifications assignment
module "signalfx-detectors-smart-agent-system-common-advanced" {
  source        = "github.com/claranet/terraform-signalfx-detectors.git//modules/smart-agent_system-common?ref=v1.7.0"
  environment   = var.environment

  # Use our local defined above to easily map notifications for all detectors of the module
  notifications = local.notifications

  # We also enable the disk forecast detector for predictive alerting
  disk_running_out_disabled = false
  
  # However, for this detector only we do not want to create oncall incident so we override its notifications
  disk_running_out_notifications = {
    critical = [module.signalfx-integrations-alerting-slack.sfx_integration_notification]
    major    = [module.signalfx-integrations-alerting-slack.sfx_integration_notification]
    minor    = [module.signalfx-integrations-alerting-slack.sfx_integration_notification]
    warning  = [module.signalfx-integrations-alerting-slack.sfx_integration_notification]
    info     = [module.signalfx-integrations-alerting-slack.sfx_integration_notification]
  }
  # We could only define the `major` severity because at this moment, the detector only has one rule for this
  # severity. However, we prefer to define all severities to handle any change for future versions which
  # could add more rules or change the severity of the existing one
}
