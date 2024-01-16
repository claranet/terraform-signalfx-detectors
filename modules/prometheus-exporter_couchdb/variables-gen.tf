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

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = 900
}

variable "heartbeat_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "heartbeat_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
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
  default     = "10m"
}

# couchdb_httpd_status_code_4xx detector

variable "couchdb_httpd_status_code_4xx_notifications" {
  description = "Notification recipients list per severity overridden for couchdb_httpd_status_code_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "couchdb_httpd_status_code_4xx_aggregation_function" {
  description = "Aggregation function and group by for couchdb_httpd_status_code_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['sf_metric'])"
}

variable "couchdb_httpd_status_code_4xx_transformation_function" {
  description = "Transformation function for couchdb_httpd_status_code_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
}

variable "couchdb_httpd_status_code_4xx_max_delay" {
  description = "Enforce max delay for couchdb_httpd_status_code_4xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "couchdb_httpd_status_code_4xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "couchdb_httpd_status_code_4xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "couchdb_httpd_status_code_4xx_disabled" {
  description = "Disable all alerting rules for couchdb_httpd_status_code_4xx detector"
  type        = bool
  default     = null
}

variable "couchdb_httpd_status_code_4xx_disabled_critical" {
  description = "Disable critical alerting rule for couchdb_httpd_status_code_4xx detector"
  type        = bool
  default     = null
}

variable "couchdb_httpd_status_code_4xx_disabled_major" {
  description = "Disable major alerting rule for couchdb_httpd_status_code_4xx detector"
  type        = bool
  default     = null
}

variable "couchdb_httpd_status_code_4xx_threshold_critical" {
  description = "Critical threshold for couchdb_httpd_status_code_4xx detector"
  type        = number
  default     = 30
}

variable "couchdb_httpd_status_code_4xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "couchdb_httpd_status_code_4xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "couchdb_httpd_status_code_4xx_threshold_major" {
  description = "Major threshold for couchdb_httpd_status_code_4xx detector"
  type        = number
  default     = 20
}

variable "couchdb_httpd_status_code_4xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "couchdb_httpd_status_code_4xx_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# couchdb_auth_cache detector

variable "couchdb_auth_cache_notifications" {
  description = "Notification recipients list per severity overridden for couchdb_auth_cache detector"
  type        = map(list(string))
  default     = {}
}

variable "couchdb_auth_cache_aggregation_function" {
  description = "Aggregation function and group by for couchdb_auth_cache detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['sf_metric'])"
}

variable "couchdb_auth_cache_transformation_function" {
  description = "Transformation function for couchdb_auth_cache detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
}

variable "couchdb_auth_cache_max_delay" {
  description = "Enforce max delay for couchdb_auth_cache detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "couchdb_auth_cache_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "couchdb_auth_cache_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "couchdb_auth_cache_disabled" {
  description = "Disable all alerting rules for couchdb_auth_cache detector"
  type        = bool
  default     = null
}

variable "couchdb_auth_cache_disabled_critical" {
  description = "Disable critical alerting rule for couchdb_auth_cache detector"
  type        = bool
  default     = null
}

variable "couchdb_auth_cache_disabled_major" {
  description = "Disable major alerting rule for couchdb_auth_cache detector"
  type        = bool
  default     = null
}

variable "couchdb_auth_cache_threshold_critical" {
  description = "Critical threshold for couchdb_auth_cache detector"
  type        = number
  default     = 10
}

variable "couchdb_auth_cache_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "couchdb_auth_cache_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "couchdb_auth_cache_threshold_major" {
  description = "Major threshold for couchdb_auth_cache detector"
  type        = number
  default     = 5
}

variable "couchdb_auth_cache_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "couchdb_auth_cache_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# couchdb_couch_replicator_jobs detector

variable "couchdb_couch_replicator_jobs_notifications" {
  description = "Notification recipients list per severity overridden for couchdb_couch_replicator_jobs detector"
  type        = map(list(string))
  default     = {}
}

variable "couchdb_couch_replicator_jobs_aggregation_function" {
  description = "Aggregation function and group by for couchdb_couch_replicator_jobs detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['sf_metric'])"
}

variable "couchdb_couch_replicator_jobs_transformation_function" {
  description = "Transformation function for couchdb_couch_replicator_jobs detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
}

variable "couchdb_couch_replicator_jobs_max_delay" {
  description = "Enforce max delay for couchdb_couch_replicator_jobs detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "couchdb_couch_replicator_jobs_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "couchdb_couch_replicator_jobs_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "couchdb_couch_replicator_jobs_disabled" {
  description = "Disable all alerting rules for couchdb_couch_replicator_jobs detector"
  type        = bool
  default     = null
}

variable "couchdb_couch_replicator_jobs_disabled_critical" {
  description = "Disable critical alerting rule for couchdb_couch_replicator_jobs detector"
  type        = bool
  default     = null
}

variable "couchdb_couch_replicator_jobs_disabled_major" {
  description = "Disable major alerting rule for couchdb_couch_replicator_jobs detector"
  type        = bool
  default     = null
}

variable "couchdb_couch_replicator_jobs_threshold_critical" {
  description = "Critical threshold for couchdb_couch_replicator_jobs detector"
  type        = number
  default     = 10
}

variable "couchdb_couch_replicator_jobs_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "couchdb_couch_replicator_jobs_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "couchdb_couch_replicator_jobs_threshold_major" {
  description = "Major threshold for couchdb_couch_replicator_jobs detector"
  type        = number
  default     = 5
}

variable "couchdb_couch_replicator_jobs_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "couchdb_couch_replicator_jobs_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# couchdb_erlang_processes detector

variable "couchdb_erlang_processes_notifications" {
  description = "Notification recipients list per severity overridden for couchdb_erlang_processes detector"
  type        = map(list(string))
  default     = {}
}

variable "couchdb_erlang_processes_aggregation_function" {
  description = "Aggregation function and group by for couchdb_erlang_processes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['sf_metric'])"
}

variable "couchdb_erlang_processes_transformation_function" {
  description = "Transformation function for couchdb_erlang_processes detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
}

variable "couchdb_erlang_processes_max_delay" {
  description = "Enforce max delay for couchdb_erlang_processes detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "couchdb_erlang_processes_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "couchdb_erlang_processes_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "couchdb_erlang_processes_disabled" {
  description = "Disable all alerting rules for couchdb_erlang_processes detector"
  type        = bool
  default     = null
}

variable "couchdb_erlang_processes_disabled_critical" {
  description = "Disable critical alerting rule for couchdb_erlang_processes detector"
  type        = bool
  default     = null
}

variable "couchdb_erlang_processes_disabled_major" {
  description = "Disable major alerting rule for couchdb_erlang_processes detector"
  type        = bool
  default     = null
}

variable "couchdb_erlang_processes_threshold_critical" {
  description = "Critical threshold for couchdb_erlang_processes detector"
  type        = number
  default     = 90
}

variable "couchdb_erlang_processes_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "couchdb_erlang_processes_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "couchdb_erlang_processes_threshold_major" {
  description = "Major threshold for couchdb_erlang_processes detector"
  type        = number
  default     = 80
}

variable "couchdb_erlang_processes_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "couchdb_erlang_processes_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cluster_is_stable detector

variable "cluster_is_stable_notifications" {
  description = "Notification recipients list per severity overridden for cluster_is_stable detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_is_stable_aggregation_function" {
  description = "Aggregation function and group by for cluster_is_stable detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cluster_is_stable_max_delay" {
  description = "Enforce max delay for cluster_is_stable detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cluster_is_stable_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cluster_is_stable_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cluster_is_stable_disabled" {
  description = "Disable all alerting rules for cluster_is_stable detector"
  type        = bool
  default     = null
}

variable "cluster_is_stable_threshold_critical" {
  description = "Critical threshold for cluster_is_stable detector"
  type        = number
  default     = 1
}

variable "cluster_is_stable_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_is_stable_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
