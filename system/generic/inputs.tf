# System generic specific

variable "cpu_threshold_warning" {
	description = "CPU high warning threshold"
	default = 85
}

variable "cpu_threshold_critical" {
	description = "CPU high critical threshold"
	default = 90
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

variable "memory_timeframe" {
  description = "Monitor timeframe in Second(s), Minute(m), Hour(h), Day(d)"
  default = "5m"
}

variable "memory_threshold_warning" {
	description = "Free disk space warning threshold"
	default = 10
}

variable "memory_threshold_critical" {
	description = "Free disk space critical threshold"
	default = 5
}

