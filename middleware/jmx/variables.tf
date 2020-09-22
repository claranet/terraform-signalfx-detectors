# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Default notification recipients list per severity"
  type = object({
    critical = list(string)
    major    = list(string)
    minor    = list(string)
    warning  = list(string)
    info     = list(string)
  })
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

# jmx detectors specific

variable "jmx_memory_heap_usage_disabled_warning" {
  type    = bool
  default = null
}

variable "jmx_memory_heap_usage_notifications_warning" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_heap_usage_disabled_critical" {
  type    = bool
  default = null
}

variable "jmx_memory_heap_usage_notifications_critical" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_heap_used_aggregation_function" {
  description = "Aggregation function and group by for jmx memory used detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_heap_used_transformation_function" {
  description = "Transformation function for jmx memory used detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_heap_max_aggregation_function" {
  description = "Aggregation function and group by for jmx memory max detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_heap_max_transformation_function" {
  description = "Transformation function for jmx memory max detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_thread_count_disabled_warning" {
  type    = bool
  default = null
}

variable "jmx_thread_count_notifications_warning" {
  type    = map(list(string))
  default = {}
}

variable "jmx_thread_count_disabled_critical" {
  type    = bool
  default = null
}

variable "jmx_thread_count_notifications_critical" {
  type    = map(list(string))
  default = {}
}

variable "jmx_thread_count_aggregation_function" {
  description = "Aggregation function and group by for jmx memory used detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_thread_count_transformation_function" {
  description = "Transformation function for jmx memory used detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_non_heap_usage_disabled_warning" {
  type    = bool
  default = null
}

variable "jmx_memory_non_heap_usage_notifications_warning" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_non_heap_usage_disabled_critical" {
  type    = bool
  default = null
}

variable "jmx_memory_non_heap_usage_notifications_critical" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_non_heap_used_aggregation_function" {
  description = "Aggregation function and group by for jmx non heap memory used detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_non_heap_used_transformation_function" {
  description = "Transformation function for jmx non heap memory used detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_non_heap_max_aggregation_function" {
  description = "Aggregation function and group by for jmx non heap memory max detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_non_heap_max_transformation_function" {
  description = "Transformation function for jmx non heap memory max detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_codecache_space_usage_disabled_warning" {
  type    = bool
  default = null
}

variable "jmx_memory_codecache_space_usage_notifications_warning" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_codecache_space_usage_disabled_critical" {
  type    = bool
  default = null
}

variable "jmx_memory_codecache_space_usage_notifications_critical" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_codecache_space_used_aggregation_function" {
  description = "Aggregation function and group by for jmx memory codecache space used detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_codecache_space_used_transformation_function" {
  description = "Transformation function for jmx memory codecache space used detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_codecache_space_max_aggregation_function" {
  description = "Aggregation function and group by for jmx memory codecache space max detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_codecache_space_max_transformation_function" {
  description = "Transformation function for jmx memory codecache space max detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_geometry_metaspace_space_usage_disabled_warning" {
  type    = bool
  default = null
}

variable "jmx_memory_geometry_metaspace_space_usage_notifications_warning" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_geometry_metaspace_space_usage_disabled_critical" {
  type    = bool
  default = null
}

variable "jmx_memory_geometry_metaspace_space_usage_notifications_critical" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_geometry_metaspace_space_used_aggregation_function" {
  description = "Aggregation function and group by for jmx memory metaspace space used detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_geometry_metaspace_space_used_transformation_function" {
  description = "Transformation function for jmx memory metaspace space used detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_geometry_metaspace_space_max_aggregation_function" {
  description = "Aggregation function and group by for jmx memory max metaspace space detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_geometry_metaspace_space_max_transformation_function" {
  description = "Transformation function for jmx memory max metaspace space detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_g1_old_gen_space_usage_disabled_warning" {
  type    = bool
  default = null
}

variable "jmx_memory_g1_old_gen_space_usage_notifications_warning" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_g1_old_gen_space_usage_disabled_critical" {
  type    = bool
  default = null
}

variable "jmx_memory_g1_old_gen_space_usage_notifications_critical" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_g1_old_gen_space_used_aggregation_function" {
  description = "Aggregation function and group by for jmx memory used detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_g1_old_gen_space_used_transformation_function" {
  description = "Transformation function for jmx memory used detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_g1_old_gen_space_max_aggregation_function" {
  description = "Aggregation function and group by for jmx memory max detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_g1_old_gen_space_max_transformation_function" {
  description = "Transformation function for jmx memory max detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_compressed_class_space_usage_disabled_warning" {
  type    = bool
  default = null
}

variable "jmx_memory_compressed_class_space_usage_notifications_warning" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_compressed_class_space_usage_disabled_critical" {
  type    = bool
  default = null
}

variable "jmx_memory_compressed_class_space_usage_notifications_critical" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_compressed_class_space_used_aggregation_function" {
  description = "Aggregation function and group by for jmx compressed class memory used detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_compressed_class_space_used_transformation_function" {
  description = "Transformation function for jmx memory compressed class used detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_compressed_class_space_max_aggregation_function" {
  description = "Aggregation function and group by for jmx memory compressed class max detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_compressed_class_space_max_transformation_function" {
  description = "Transformation function for jmx memory compressed class max detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_survivor_space_usage_disabled_warning" {
  type    = bool
  default = null
}

variable "jmx_memory_survivor_space_usage_notifications_warning" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_survivor_space_usage_disabled_critical" {
  type    = bool
  default = null
}

variable "jmx_memory_survivor_space_usage_notifications_critical" {
  type    = map(list(string))
  default = {}
}

variable "jmx_memory_survivor_space_used_aggregation_function" {
  description = "Aggregation function and group by for jmx memory survivor space used detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_survivor_space_used_transformation_function" {
  description = "Transformation function for jmx memory survivor space used detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "jmx_memory_survivor_space_max_aggregation_function" {
  description = "Aggregation function and group by for jmx memory survivor space max detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "jmx_memory_survivor_space_max_transformation_function" {
  description = "Transformation function for jmx memory survivor space max detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

# jmx threshold

variable "jmx_memory_heap_usage_threshold_warning" {
  description = "Warning threshold for jmx heap usage"
  type        = number
  default     = 80
}

variable "jmx_memory_heap_usage_threshold_critical" {
  description = "critical threshold for jmx heap usage"
  type        = number
  default     = 90
}

variable "jmx_thread_count_threshold_warning" {
  description = "Warning threshold for jmx heap usage"
  type        = number
  default     = 400
}

variable "jmx_thread_count_threshold_critical" {
  description = "critical threshold for jmx heap usage"
  type        = number
  default     = 500
}

variable "jmx_memory_non_heap_usage_threshold_warning" {
  description = "Warning threshold for jmx non heap usage"
  type        = number
  default     = 80
}

variable "jmx_memory_non_heap_usage_threshold_critical" {
  description = "critical threshold for jmx non heap usage"
  type        = number
  default     = 90
}

variable "jmx_memory_geometry_metaspace_space_usage_threshold_warning" {
  description = "Warning threshold for jmx metaspace usage"
  type        = number
  default     = 80
}

variable "jmx_memory_geometry_metaspace_space_usage_threshold_critical" {
  description = "critical threshold for jmx metaspace usage"
  type        = number
  default     = 90
}

variable "jmx_memory_survivor_space_usage_threshold_warning" {
  description = "Warning threshold for jmx survivor usage"
  type        = number
  default     = 80
}

variable "jmx_memory_survivor_space_usage_threshold_critical" {
  description = "critical threshold for jmx survivor usage"
  type        = number
  default     = 90
}

variable "jmx_memory_compressed_class_space_usage_threshold_warning" {
  description = "Warning threshold for jmx compressed usage"
  type        = number
  default     = 80
}

variable "jmx_memory_compressed_class_space_usage_threshold_critical" {
  description = "critical threshold for jmx compressed usage"
  type        = number
  default     = 90
}

variable "jmx_memory_g1_old_gen_space_usage_threshold_warning" {
  description = "Warning threshold for jmx  G1 old gen usage"
  type        = number
  default     = 80
}

variable "jmx_memory_g1_old_gen_space_usage_threshold_critical" {
  description = "critical threshold for jmx G1 old gen usage"
  type        = number
  default     = 90
}

variable "jmx_memory_codecache_space_usage_threshold_warning" {
  description = "Warning threshold for jmx codecache usage"
  type        = number
  default     = 80
}

variable "jmx_memory_codecache_space_usage_threshold_critical" {
  description = "critical threshold for jmx codecache usage"
  type        = number
  default     = 90
}
