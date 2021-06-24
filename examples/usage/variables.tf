# could be set from `TF_VAR_environment` env var
variable "environment" {
  description = "The environment used as parameter to configure detectors modules"
  type        = string
}

variable "pagerduty_token_nbh" {
  description = "The PagerDuty token for Non Business Hours"
  type        = string
}

variable "pagerduty_token_bh" {
  description = "The PagerDuty token for Business Hours"
  type        = string
}

variable "slack_webhook_url" {
  description = "The Slack webhook URL"
  type        = string
}

variable "slack_channel_name" {
  description = "The Slack channel"
  type        = string
}

