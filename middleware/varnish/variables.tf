# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

variable "varnish_backend_failed_disabled" {
  type    = bool
  default = null
}

variable "varnish_backend_failed_notifications" {
  description = "Notification recipients list for every alerting rules of backend_failed detector"
  type        = list
  default     = []
}

variable "varnish_threads_number_disabled" {
  type    = bool
  default = null
}

variable "varnish_threads_number_notifications" {
  description = "Notification recipients list for every alerting rules of threads_number detector"
  type        = list
  default     = []
}

variable "varnish_session_dropped_disabled" {
  type    = bool
  default = null
}

variable "varnish_session_dropped_notifications" {
  description = "Notification recipients list for every alerting rules of session_dropped detector"
  type        = list
  default     = []
}

variable "varnish_cache_hit_rate_disabled" {
  description = "Disable all alerting rules for cache_hit_rate detector"
  type        = bool
  default     = null
}

variable "varnish_cache_hit_rate_disabled_warning" {
  description = "Disable warning alerting rule for cache_hit_rate detector"
  type        = bool
  default     = null
}

variable "varnish_cache_hit_rate_disabled_major" {
  description = "Disable major alerting rule for cache_hit_rate detector"
  type        = bool
  default     = null
}

variable "varnish_cache_hit_rate_notifications" {
  description = "Notification recipients list for every alerting rules of cache_hit_rate detector"
  type        = list
  default     = []
}

variable "varnish_cache_hit_rate_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cache_hit_rate detector"
  type        = list
  default     = []
}

variable "varnish_cache_hit_rate_notifications_major" {
  description = "Notification recipients list for major alerting rule of cache_hit_rate detector"
  type        = list
  default     = []
}

variable "varnish_memory_usage_disabled" {
  description = "Disable all alerting rules for memory_usage detector"
  type        = bool
  default     = null
}

variable "varnish_memory_usage_disabled_critical" {
  description = "Disable critical alerting rule for memory_usage detector"
  type        = bool
  default     = null
}

variable "varnish_memory_usage_disabled_warning" {
  description = "Disable warning alerting rule for memory_usage detector"
  type        = bool
  default     = null
}

variable "varnish_memory_usage_notifications" {
  description = "Notification recipients list for every alerting rules of memory_usage detector"
  type        = list
  default     = []
}

variable "varnish_memory_usage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_usage detector"
  type        = list
  default     = []
}

variable "varnish_memory_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_usage detector"
  type        = list
  default     = []
}

# Varnish detectors specific

variable "varnish_backend_failed_aggregation_function" {
  description = "Aggregation function and group by for varnish backend failed detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "varnish_backend_failed_transformation_function" {
  description = "Transformation function for varnish backend failed detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "varnish_session_dropped_aggregation_function" {
  description = "Aggregation function and group by for varnish session dropped detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "varnish_session_dropped_transformation_function" {
  description = "Transformation function for varnish session dropped detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "varnish_threads_number_aggregation_function" {
  description = "Aggregation function and group by for varnish threads number detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "varnish_threads_number_transformation_function" {
  description = "Transformation function for varnish threads number detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "varnish_cache_hit_rate_aggregation_function" {
  description = "Aggregation function and group by for varnish cache hit rate detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "varnish_cache_hit_rate_transformation_function" {
  description = "Transformation function for varnish cache hit rate detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "varnish_memory_usage_aggregation_function" {
  description = "Aggregation function and group by for varnish memory usage aggregation detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "varnish_memory_usage_transformation_function" {
  description = "Transformation function for varnish memory usage aggregation detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

# Varnish threshold

variable "varnish_backend_failed_threshold_critical" {
  description = "Critical threshold for varnish backend"
  type        = number
  default     = 0
}

variable "varnish_session_dropped_threshold_critical" {
  description = "Critical threshold for varnish session dropped"
  type        = number
  default     = 0
}

variable "varnish_cache_hit_rate_threshold_major" {
  description = "Varnish cache hit rate threshold major"
  type        = number
  default     = 90
}

variable "varnish_cache_hit_rate_threshold_warning" {
  description = "Varnish cache hit rate threshold warning"
  type        = number
  default     = 80
}

variable "varnish_threads_threshold_critical" {
  description = "Varnish threads number threshold critical"
  type        = number
  default     = 1
}

variable "varnish_memory_usage_threshold_warning" {
  description = "Varnish memory usage threshold warning"
  type        = number
  default     = 80
}

variable "varnish_memory_usage_threshold_critical" {
  description = "Varnish memory usage threshold critical"
  type        = number
  default     = 90
}

