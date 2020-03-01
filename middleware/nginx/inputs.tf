# Global

variable "environment" {
	description = "Architecture Environment"
	type = string
}

# SignalFx specific

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

#####

variable "nginx_critical_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "nginx_filter" {
	description = "(Optional) Nginx filter criteria. Examples `, filter=filter('plugin', 'kong')` 
	default = ", filter=filter('plugin', 'nginx')"
}

variable "nginx_aggregation_function" {
	description = "(Optional) Nginx aggregation function and group by. Examples `.mean(by=['host']).` or `.max()` 
	default = ".mean(by=['host'])"
}

variable "nginx_transformation_function" {
	description = Nginx transformation function.  Valid options mean, min, max"
	default = "min"
}

variable "nginx_transformation_window" {
	description = "Nginx transformation window. Examples 5m, 20m, 1h, 1d"
	default = "5m"
}

variable "nginx_threshold_critical" {
	description = "Nginx critical threshold"
	default = 0
}
