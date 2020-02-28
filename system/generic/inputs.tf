# System generic specific

variable "environment" {
	description = "Architecture Environment"
	type = string
}

variable "prefix_slug" {
	description = "Prefix string to prepend between brackets on every monitors names"
	default = ""
}

#####

variable "system_heartbeat_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "system_heartbeat_timeframe" {
	description = "Timeframe for system not reporting"
	default = "20m"
}

#####

variable "cpu_critical_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "cpu_warning_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "cpu_aggregation_function" {
	description = "(Optional) CPU aggregation function and group by.  Examples `mean(by=['host']).` or `max().` 
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

variable "cpu_threshold_warning" {
	description = "CPU high warning threshold"
	default = 85
}

variable "cpu_threshold_critical" {
	description = "CPU high critical threshold"
	default = 90
}

#####

variable "load_warning_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "load_critical_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "load_aggregation_function" {
	description = "(Optional) Load aggregation function and group by.  Examples `mean(by=['host']).` or `max().` 
	default = ""
}

variable "load_transformation_function" {
	description = "Load time transformation function.  Valid options mean, min, max"
	default = "min"
}

variable "load_transformation_window" {
	description = "CPU time transformation window. Examples 5m, 20m, 1h, 1d"
	default = "30m"
}

variable "load_threshold_warning" {
	description = "CPU load ratio warning threshold"
	default = 2
}

variable "load_threshold_critical" {
	description = "CPU load ratio critical threshold"
	default = 2.5
}

#####

variable "disk_space_warning_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}
		
variable "disk_space_critical_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}		

variable "disk_space_aggregation_function" {
	description = "(Optional) Disk Space aggregation function and group by.  Examples `mean(by=['host', 'plugin_instance']).` or `max().` 
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

variable "disk_space_threshold_warning" {
	description = "Free disk space warning threshold"
	default = 80
}

variable "disk_space_threshold_critical" {
	description = "Free disk space critical threshold"
	default = 90
}

#####

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

#####

variable "memory_warning_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "memory_critical_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "memory_aggregation_function" {
	description = "(Optional) Memory aggregation function and group by.  Examples `mean(by=['host']).` or `max().` 
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

variable "memory_threshold_warning" {
	description = "Memory warning threshold"
	default = 10
}

variable "memory_threshold_critical" {
	description = "Memory critical threshold"
	default = 5
}
