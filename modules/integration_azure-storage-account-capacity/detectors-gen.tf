resource "signalfx_detector" "used_capacity" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account capacity used")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Gibibyte"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true')
    capacity = data('UsedCapacity', filter=base_filtering and ${module.filtering.signalflow})${var.used_capacity_aggregation_function}${var.used_capacity_transformation_function}
    signal = capacity.scale(1/1024**3).publish('signal')
    detect(when(signal > ${var.used_capacity_threshold_critical}, lasting=%{if var.used_capacity_lasting_duration_critical == null}None%{else}'${var.used_capacity_lasting_duration_critical}'%{endif}, at_least=${var.used_capacity_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.used_capacity_threshold_major}, lasting=%{if var.used_capacity_lasting_duration_major == null}None%{else}'${var.used_capacity_lasting_duration_major}'%{endif}, at_least=${var.used_capacity_at_least_percentage_major}) and (not when(signal > ${var.used_capacity_threshold_critical}, lasting=%{if var.used_capacity_lasting_duration_critical == null}None%{else}'${var.used_capacity_lasting_duration_critical}'%{endif}, at_least=${var.used_capacity_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.used_capacity_threshold_critical}Gibibyte"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.used_capacity_disabled_critical, var.used_capacity_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.used_capacity_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.used_capacity_runbook_url, var.runbook_url), "")
    tip                   = var.used_capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.used_capacity_threshold_major}Gibibyte"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.used_capacity_disabled_major, var.used_capacity_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.used_capacity_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.used_capacity_runbook_url, var.runbook_url), "")
    tip                   = var.used_capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.used_capacity_max_delay
}

