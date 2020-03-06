# Global

variable "environment" {
	description = "Architecture Environment"
	type        = string
}

# SignalFx Module specific

variable "notifications" {
	description = "Notification recipients semicolon separated (i.e. \"Email,my@mail.com;PagerDuty,credentialId\")"
	type        = string
}

variable "prefixes_slug" {
	description = "Prefixes list to prepend between brackets on every monitors names before environment"
	type        = list
	default     = []
}

variable "filter_use_defaults" {
	description = "Use default filtering which follows tagging convention"
	type        = bool
	default     = true
}

variable "filter_custom_includes" {
	description = "Tags to filter signals on when custom filtering is used (i.e \"tag1:val1;tag2:val2\")"
	type        = string
	default     = ""
}

variable "filter_custom_excludes" {
	description = "Tags to exclude when using custom filtering (i.e \"tag1:val1;tag2:val2\")"
	type        = string
	default     = ""
}

variable "detectors_disabled" {
	description = "Disable all detectors in this module"
	type        = bool
	default     = false
}

# Kong Detector specific

variable "heartbeat_disabled" {
	description = "Disable all alerting rules for heartbeat detector"
	type        = bool
	default     = null
}

variable "heartbeat_notifications" {
	description = "Notification recipients semicolon for every alerting rules of heartbeat detector"
	type        = string
	default     = ""
}

variable "heartbeat_timeframe" {
	description = "Timeframe for system not reporting detector (i.e. \"10m\")"
	type        = string
	default     = "20m"
}

#####

variable "treatment_limit_disabled" {
	description = "Disable all alerting rules for treatment limit detector"
	type        = bool
	default     = null
}

variable "treatment_limit_disabled_critical" {
	description = "Disable critical alerting rule for treatment limit detector"
	type        = bool
	default     = null
}

variable "treatment_limit_disabled_warning" {
	description = "Disable warning alerting rule for treatment limit detector"
	type        = bool
	default     = null
}

variable "treatment_limit_notifications" {
	description = "Notification recipients semicolon for every alerting rules of treatment limit detector"
	type        = string
	default     = ""
}

variable "treatment_limit_notifications_warning" {
	description = "Notification recipients semicolon for warning alerting rule of treatment limit detector"
	type        = string
	default     = ""
}

variable "treatment_limit_notifications_critical" {
	description = "Notification recipients semicolon for critical alerting rule of treatment limit detector"
	type        = string
	default     = ""
}

variable "treatment_limit_aggregation_function" {
	description = "Aggregation function and group by for treatment limit detector (i.e. \".mean(by=['host']).\")"
	type        = string
	default     = ""
}

variable "treatment_limit_transformation_function" {
	description = "Transformation function for treatment limit detector (mean, min, max)"
	type        = string
	default     = "min"
}

variable "treatment_limit_transformation_window" {
	description = "Transformation window for treatment limit detector (i.e. 5m, 20m, 1h, 1d)"
	type        = string
	default     = "15m"
}

variable "treatment_limit_threshold_critical" {
	description = "Critical threshold for treatment limit detector"
	type        = number
	default     = 20
}

variable "treatment_limit_threshold_warning" {
	description = "Warning threshold for treatment limit detector"
	type        = number
	default     = 0
}

