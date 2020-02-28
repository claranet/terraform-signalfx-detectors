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

variable "treatment_limit_threshold_critical" {
	description = "Docker Container memory usage critical threshold"
	default = 20
}
