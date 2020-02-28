#Global

variable "environment" {
	description = "Architecture Environment"
	type = string
}

#SignalFx Specific

variable "prefix_slug" {
	description = "Prefix string to prepend between brackets on every monitors names"
	default = ""
}


# Nginx Detector specific

variable "nginx_heartbeat_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "nginx_heartbeat_timeframe" {
	description = "Timeframe for system not reporting"
	default = "20m"
}

variable "nginx_dropped_threshold_critical" {
	description = "Nginx dropped connections critical threshold"
	default = 0
}
