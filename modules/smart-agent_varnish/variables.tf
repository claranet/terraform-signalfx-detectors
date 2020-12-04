# Module specific

# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# backend_failed detector

variable "backend_failed_disabled" {
  description = "Disable all alerting rules for backend_failed detector"
  type        = bool
  default     = null
}

variable "backend_failed_notifications" {
  description = "Notification recipients list per severity overridden for backend_failed detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_failed_aggregation_function" {
  description = "Aggregation function and group by for varnish backend failed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backend_failed_transformation_function" {
  description = "Transformation function for varnish backend failed detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "backend_failed_threshold_critical" {
  description = "Critical threshold for varnish backend"
  type        = number
  default     = 0
}

# threads_number detector

variable "threads_number_disabled" {
  description = "Disable all alerting rules for threads_number detector"
  type        = bool
  default     = null
}

variable "threads_number_notifications" {
  description = "Notification recipients list per severity overridden for threads_number detector"
  type        = map(list(string))
  default     = {}
}

variable "threads_number_aggregation_function" {
  description = "Aggregation function and group by for varnish threads number detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "threads_number_transformation_function" {
  description = "Transformation function for varnish threads number detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "threads_threshold_critical" {
  description = "Varnish threads number threshold critical"
  type        = number
  default     = 1
}

# session_dropped detector

variable "session_dropped_disabled" {
  description = "Disable all alerting rules for session_dropped detector"
  type        = bool
  default     = null
}

variable "session_dropped_notifications" {
  description = "Notification recipients list per severity overridden for session_dropped detector"
  type        = map(list(string))
  default     = {}
}

variable "session_dropped_aggregation_function" {
  description = "Aggregation function and group by for varnish session dropped detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "session_dropped_transformation_function" {
  description = "Transformation function for varnish session dropped detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "session_dropped_threshold_critical" {
  description = "Critical threshold for varnish session dropped"
  type        = number
  default     = 0
}

# cache_hit_rate detector

variable "cache_hit_rate_disabled" {
  description = "Disable all alerting rules for cache_hit_rate detector"
  type        = bool
  default     = null
}

variable "cache_hit_rate_disabled_major" {
  description = "Disable major alerting rule for cache_hit_rate detector"
  type        = bool
  default     = null
}

variable "cache_hit_rate_disabled_minor" {
  description = "Disable minor alerting rule for cache_hit_rate detector"
  type        = bool
  default     = null
}

variable "cache_hit_rate_notifications" {
  description = "Notification recipients list per severity overridden for cache_hit_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "cache_hit_rate_aggregation_function" {
  description = "Aggregation function and group by for varnish cache hit rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cache_hit_rate_transformation_function" {
  description = "Transformation function for varnish cache hit rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "cache_hit_rate_threshold_minor" {
  description = "Varnish cache hit rate threshold minor"
  type        = number
  default     = 90
}

variable "cache_hit_rate_threshold_major" {
  description = "Varnish cache hit rate threshold major"
  type        = number
  default     = 80
}

# memory_usage detector

variable "memory_usage_disabled" {
  description = "Disable all alerting rules for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_disabled_critical" {
  description = "Disable critical alerting rule for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_disabled_major" {
  description = "Disable major alerting rule for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_notifications" {
  description = "Notification recipients list per severity overridden for memory_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_usage_aggregation_function" {
  description = "Aggregation function and group by for varnish memory usage aggregation detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_usage_transformation_function" {
  description = "Transformation function for varnish memory usage aggregation detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "memory_usage_threshold_major" {
  description = "Varnish memory usage threshold major"
  type        = number
  default     = 80
}

variable "memory_usage_threshold_critical" {
  description = "Varnish memory usage threshold critical"
  type        = number
  default     = 90
}


