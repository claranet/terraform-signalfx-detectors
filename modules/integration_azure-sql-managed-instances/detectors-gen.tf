resource "signalfx_detector" "cpu" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Managed Instances cpu")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Sql/managedInstances') and filter('primary_aggregation_type', 'true')
    signal = data('avg_cpu_percent', filter=base_filtering and ${module.filtering.signalflow}, rollup='max')${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_threshold_critical}%{if var.cpu_lasting_duration_critical != null}, lasting='${var.cpu_lasting_duration_critical}', at_least=${var.cpu_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.cpu_threshold_major}%{if var.cpu_lasting_duration_major != null}, lasting='${var.cpu_lasting_duration_major}', at_least=${var.cpu_at_least_percentage_major}%{endif}) and (not when(signal > ${var.cpu_threshold_critical}%{if var.cpu_lasting_duration_critical != null}, lasting='${var.cpu_lasting_duration_critical}', at_least=${var.cpu_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_disabled_critical, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_max_delay
}

resource "signalfx_detector" "storage_usage" {
  name = format("%s %s", local.detector_name_prefix, "Azure SQL Managed Instances storage usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Sql/managedInstances') and filter('primary_aggregation_type', 'true')
    A = data('storage_space_used_mb', filter=base_filtering and ${module.filtering.signalflow})${var.storage_usage_aggregation_function}${var.storage_usage_transformation_function}
    B = data('reserved_storage_mb', filter=base_filtering and ${module.filtering.signalflow})${var.storage_usage_aggregation_function}${var.storage_usage_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.storage_usage_threshold_critical}%{if var.storage_usage_lasting_duration_critical != null}, lasting='${var.storage_usage_lasting_duration_critical}', at_least=${var.storage_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.storage_usage_threshold_major}%{if var.storage_usage_lasting_duration_major != null}, lasting='${var.storage_usage_lasting_duration_major}', at_least=${var.storage_usage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.storage_usage_threshold_critical}%{if var.storage_usage_lasting_duration_critical != null}, lasting='${var.storage_usage_lasting_duration_critical}', at_least=${var.storage_usage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.storage_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.storage_usage_disabled_critical, var.storage_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.storage_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.storage_usage_runbook_url, var.runbook_url), "")
    tip                   = var.storage_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.storage_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.storage_usage_disabled_major, var.storage_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.storage_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.storage_usage_runbook_url, var.runbook_url), "")
    tip                   = var.storage_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.storage_usage_max_delay
}

