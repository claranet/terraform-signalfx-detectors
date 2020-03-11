variable "filter_defaults" {
  description = "Filters as SignalFlow string to use when using default filtering convention"
  type        = string
  default     = ""
}

variable "filter_custom_includes" {
  description = "Filters list to include when custom filtering is used"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "Filters list to exclude when custom filtering is used"
  type        = list
  default     = []
}

