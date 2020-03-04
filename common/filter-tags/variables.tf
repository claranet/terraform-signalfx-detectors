variable "filter_use_defaults" {
  description = "Use default filtering convention"
  default     = "true"
}

variable "filter_defaults" {
  description = "Default filters to apply "
  default     = ""
}

variable "filter_custom_includes" {
  description = "Tags to filter signals on when custom filtering is used. Enter as string i.e \"tag1:val1;tag2:val2\""
  default     = ""
}

variable "filter_custom_excludes" {
  description = "Tags to exclude when using custom filtering. Enter as string i.e \"tag1:val1;tag2:val2\""
  default     = ""
}
