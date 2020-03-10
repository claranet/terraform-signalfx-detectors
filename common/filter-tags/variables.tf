variable "filter_use_defaults" {
  description = "Use default filtering convention"
  type        = bool
  default     = true
}

variable "filter_defaults" {
  description = "List of tags tu use as filters when using default filtering convention"
  type        = string
  default     = ""
}

variable "filter_custom_includes" {
  description = "Semicolon separated string of filters to include when custom filtering is used (i.e \"in1:clude1;tag2:val2\")"
  type        = string
  default     = ""
}

variable "filter_custom_excludes" {
  description = "Semicolon separated string of filters to exclude when custom filtering is used (i.e \"ex1:clude1;tag2:val2\")"
  type        = string
  default     = ""
}

