# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

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
  type        = list(string)
  default     = []
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

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

variable "runbook_url" {
  description = "Default runbook URL to apply to all detectors (if not overridden at detector level)"
  type        = string
  default     = ""
}

variable "authorized_writer_teams" {
  description = "List of teams IDs authorized (with admins) to edit the detector. If defined, it requires an user token to work"
  type        = list(string)
  default     = null
}

variable "teams" {
  description = "List of teams IDs to associate the detector to"
  type        = list(string)
  default     = null
}
