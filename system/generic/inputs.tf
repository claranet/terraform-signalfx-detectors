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

variable "cpu_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "cpu_filter_aggregation" {
	description = "CPU filter aggregation"
	default = ""
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

variable "load_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "load_filter_aggregation" {
	description = "Load filter aggregation"
	default = ""
}

variable "load_time_aggregator" {
	description = "Monitor aggregator for CPU load ratio [available values: min, max or mean]"
	default = "min"
}

variable "load_timeframe" {
	description = "Monitor timeframe in Second(s), Minute(m), Hour(h), Day(d)"
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

variable "disk_space_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "disk_space_filter_aggregation" {
	description = "Free disk space filter aggregation"
	default = ""
}

variable "disk_space_time_aggregator" {
	description = "Monitor aggregator for Free diskspace [available values: min, max or mean]"
	default = "max"
}

variable "disk_space_timeframe" {
	description = "Monitor timeframe in Second(s), Minute(m), Hour(h), Day(d)"
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

variable "memory_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "memory_filter_aggregation" {
	description = "Memory filter aggregation"
	default = ""
}

variable "memory_time_aggregator" {
	description = "Monitor aggregator for Free memory [available values: min, max or mean]"
	default = "max"
}

variable "memory_timeframe" {
	description = "Monitor timeframe in Second(s), Minute(m), Hour(h), Day(d)"
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
