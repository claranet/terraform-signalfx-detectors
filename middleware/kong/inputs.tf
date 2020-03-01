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

# Kong Detector specific

variable "kong_service_heartbeat_timeframe" {
	description = "Timeframe Kong Server has not reported for"
	default = 20
}

variable "kong_service_heartbeat_disabled_flag" {
	description = "Timeframe Kong Server has not reported for"
	default = 20
}

#####

variable "treatment_limit_warning_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "treatment_limit_critical_disabled_flag" {
	description = "(Optional) When true, notifications and events will not be generated for the detect label. false by default."
	default = "false"
}

variable "treatment_limit_filter" {
	description = "(Optional) Treatment limit filter criteria. Examples `, filter=filter('plugin', 'kong')` 
	default = ",filter=filter('plugin', 'kong')"
}

variable "treatment_limit_aggregation_function" {
	description = "(Optional) Treatment limit aggregation function and group by. Examples `.mean(by=['host']).` or `.max()` 
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

variable "treatment_limit_threshold_warning" {
	description = "Treatment limit warning threshold"
	default = 0
}

variable "treatment_limit_threshold_critical" {
	description = "Treatment limit critical threshold"
	default = 20
}
