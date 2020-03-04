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

# System generic specific

variable "system_heartbeat_disabled_flag" {
	description = "(Optional) When true, heartbeat detector will be disabled"
	default = "false"
}

variable "system_heartbeat_timeframe" {
	description = "Timeframe for system not reporting"
	default = "20m"
}

variable "system_heartbeat_notifications" {
  	description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
  	default = ""
}

#####

variable "disable_CPU_detector" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = ""
}

variable "cpu_critical_disabled_flag" {
	description = "(Optional) When true, CPU critical rule will be disabled"
	default = "false"
}

variable "cpu_warning_disabled_flag" {
	description = "(Optional) When true, CPU warning rule will be disabled"
	default = "false"
}

variable "cpu_aggregation_function" {
	description = "(Optional) CPU aggregation function and group by. Examples \".mean(by=['host']).\" or \".max()\""
	default = ""
}

variable "cpu_transformation_function" {
	description = "CPU transformation function.  Valid options mean, min, max"
	default = "min"
}

variable "cpu_transformation_window" {
	description = "CPU transformation window. Examples 5m, 20m, 1h, 1d"
	default = "1h"
}

variable "cpu_threshold_critical" {
	description = "CPU critical threshold"
	default = 90
}

variable "cpu_threshold_warning" {
	description = "CPU warning threshold"
	default = 85
}

variable "cpu_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
 	 default = ""
}

variable "cpu_warning_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
 	 default = ""
}

variable "cpu_critical_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
  	 default = ""
}

#####

variable "disable_load_detector" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = ""
}

variable "load_critical_disabled_flag" {
	description = "(Optional) When true, load critical rule will be disabled"
	default = "false"
}

variable "load_warning_disabled_flag" {
	description = "(Optional) When true, load warning rule will be disabled"
	default = "false"
}

variable "load_aggregation_function" {
	description = "(Optional) Load aggregation function and group by. Examples \".mean(by=['host']).\" or \".max()\""
	default = ""
}

variable "load_transformation_function" {
	description = "Load time transformation function.  Valid options mean, min, max"
	default = "min"
}

variable "load_transformation_window" {
	description = "Load time transformation window. Examples 5m, 20m, 1h, 1d"
	default = "30m"
}

variable "load_threshold_critical" {
	description = "Load ratio critical threshold"
	default = 2.5
}

variable "load_threshold_warning" {
	description = "Load ratio warning threshold"
	default = 2
}

variable "load_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
 	 default = ""
}

variable "load_warning_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
 	 default = ""
}

variable "load_critical_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
  	 default = ""
}

#####

variable "disable_disk_space_detector" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = ""
}

variable "disk_space_critical_disabled_flag" {
	description = "(Optional) When true, disk space critical rule will be disabled"
	default = "false"
}	

variable "disk_space_warning_disabled_flag" {
	description = "(Optional) When true, disk space warning rule be disabled"
	default = "false"
}

variable "disk_space_aggregation_function" {
	description = "(Optional) Nginx aggregation function and group by. Examples \".mean(by=['host']).\" or \".max()\""
	default = ""
}

variable "disk_space_transformation_function" {
	description = "Disk space time transformation function.  Valid options mean, min, max"
	default = "max"
}

variable "disk_space_transformation_window" {
	description = "disk space time transformation window. Examples 5m, 20m, 1h, 1d"
	default = "5m"
}

variable "disk_space_threshold_critical" {
	description = "Free disk space critical threshold"
	default = 90
}

variable "disk_space_threshold_warning" {
	description = "Free disk space warning threshold"
	default = 80
}

variable "disk_space_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
 	 default = ""
}

variable "disk_space_warning_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
 	 default = ""
}

variable "disk_space_critical_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
  	 default = ""
}

#####

variable "disable_disk_detector" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = ""
}

variable "disk_maximum_capacity" {
	description = "When to consider disk full, defined as a percentage"
	default = "95"
}

variable "disk__fire_hours_remaining" {
	description = "How manuy hours before disk is projected to be full do you want to be alerted "
	default = "72"
}

variable "disk_fire_lasting_time" {
	description = "Time condition must be true to fire"
	default = "30m"
}

variable "disk_fire_lasting_time_percent" {
	description = "Percent of fire lasting time the conditon must be true.  Expressed as decimal"
	default = ".9"
}

variable "disk_clear_hours_remaining" {
	description = "With how many hours left till disk is full can the alert clear"
	default = "96"
}

variable "disk_clear_lasting_time" {
	description = "Time clear condition must be true to clear"
	default = "30m"
}

variable "disk_clear_lasting_time_percent" {
	description = "Percent of clear lasting time the conditon must be true.  Expressed as decimal"
	default = ".9"
}

variable "disk_use_ewma" {
	description = "Use Double EWMA"
	default = "false"
}

variable "disk_running_out_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "disk_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
 	 default = ""
}

variable "disk_critical_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
  	 default = ""
}

#####

variable "disable_memory_detector" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = ""
}

variable "memory_critical_disabled_flag" {
	description = "(Optional) When true, memory critical rule will be disabled"
	default = "false"
}

variable "memory_warning_disabled_flag" {
	description = "(Optional) When true, memory warning rule will be disabled"
	default = "false"
}

variable "memory_aggregation_function" {
	description = "(Optional) Memory aggregation function and group by. Examples \".mean(by=['host']).\" or \".max()\""
	default = ""
}

variable "memory_transformation_function" {
	description = Memory time transformation function.  Valid options mean, min, max"
	default = "max"
}

variable "memory_transformation_window" {
	description = "Memory time transformation window. Examples 5m, 20m, 1h, 1d"
	default = "5m"
}

variable "memory_threshold_critical" {
	description = "Memory critical threshold"
	default = 5
}

variable "memory_threshold_warning" {
	description = "Memory warning threshold"
	default = 10
}

variable "memory_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
 	 default = ""
}

variable "memory_warning_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
 	 default = ""
}

variable "memory_critical_notifications" {
  	 description = "(Optional), notification recipients.  Example \"PagerDuty,credentialId\" or \"PagerDuty,credentialId;Slack,credentialId,channel\""
  	 default = ""
}
