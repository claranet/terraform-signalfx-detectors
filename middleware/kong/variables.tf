# Global

variable "environment" {
	description = "Architecture Environment"
	type = string
}

# SignalFx Module specific

variable "prefix_slug" {
	description = "Prefix string to prepend between brackets on every monitors names"
	default = ""
}

variable "filter_use_defaults" {
  	description = "Use default filtering convention"
  	default     = "true"
}

variable "filter_custom_includes" {
  	description = "Tags to filter signals on when custom filtering is used. Enter as string i.e \"tag1:val1;tag2:val2\""
  	default     = ""
}

variable "filter_custom_excludes" {
  	description = "Tags to exclude when using custom filtering. Enter as string i.e \"tag1:val1;tag2:val2\""
  	default = ""
}

variable "disable_detectors" {
  	description = "(Optional), set string to true if you want to disbale all detectors in this module"
  	default = "false"
}

variable "notifications" {
  	description = "(Required), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
  	default = ""
}

# Kong Detector specific

variable "kong_heartbeat_disabled_flag" {
	description = "(Optional) When true, heartbeat detector will be disabled"
	default = "false"
}

variable "kong_heartbeat_timeframe" {
	description = "Timeframe for system not reporting"
	default = "20m"
}

variable "kong_heartbeat_notifications" {
  	description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
  	default = ""
}

#####

variable "disable_kong_detector" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = ""
}

variable "treatment_limit_critical_disabled_flag" {
	description = "(Optional) When true, treatment limit critical rule will be disabled"
	default = "false"
}

variable "treatment_limit_warning_disabled_flag" {
	description = "(Optional) When true, treatment limit warning rule will be disabled"
	default = "false"
}

variable "treatment_limit_aggregation_function" {
	description = "(Optional) Treatment limit aggregation function and group by. Examples \".mean(by=['host']).\" or \".max()\""
	default = ".min(by=['host'])"
}

variable "treatment_limit_transformation_function" {
	description = Treatment limit transformation function.  Valid options mean, min, max"
	default = "min"
}

variable "treatment_limit_transformation_window" {
	description = "Treatment limit transformation window. Examples 5m, 20m, 1h, 1d"
	default = "15m"
}

variable "treatment_limit_threshold_critical" {
	description = "Treatment limit critical threshold"
	default = 20
}

variable "treatment_limit_threshold_warning" {
	description = "Treatment limit warning threshold"
	default = 0
}

variable "treatment_limit_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
 	 default = ""
}

variable "treatment_limit_warning_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
 	 default = ""
}

variable "treatment_limit_critical_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
  	 default = ""
}
