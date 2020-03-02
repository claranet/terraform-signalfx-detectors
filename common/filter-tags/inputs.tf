variable "filter_use_defaults" {
  description = "Use default filtering convention"
  default     = "true"
}

variable "filter_defaults" {
  description = Default filters to apply "
  default     = "filter('env', '${var.environment}') and filter('claranet_monitored', 'true')"
}

variable "filter_custom_include" {
  description = "Tags to filter signals on when custom filtering is used. i.e [\"tag1:val1\", \"tag2:val2\"] "
  default     = []
}

variable "filter_custom_exclude" {
  description = "Tags to exclude when using custom filtering. i.e [\"tag1:val1\", \"tag2:val2\"] "
  default     = []
}
