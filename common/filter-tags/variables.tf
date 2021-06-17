variable "filter_defaults" {
  description = "Filters as SignalFlow string to use when using default filtering convention"
  type        = string
  default     = ""
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list(string)
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list(string)
  default     = []
}

