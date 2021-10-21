resource "signalfx_detector" "jvm_memory_pressure" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch jvm memory pressure")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'upper') and filter('NodeId', '*')
    signal = data('JVMMemoryPressure', filter=base_filtering and ${module.filtering.signalflow})${var.jvm_memory_pressure_aggregation_function}${var.jvm_memory_pressure_transformation_function}.publish('signal')
    detect(when(signal > ${var.jvm_memory_pressure_threshold_critical}, lasting=%{if var.jvm_memory_pressure_lasting_duration_critical == null}None%{else}'${var.jvm_memory_pressure_lasting_duration_critical}'%{endif}, at_least=${var.jvm_memory_pressure_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.jvm_memory_pressure_threshold_major}, lasting=%{if var.jvm_memory_pressure_lasting_duration_major == null}None%{else}'${var.jvm_memory_pressure_lasting_duration_major}'%{endif}, at_least=${var.jvm_memory_pressure_at_least_percentage_major}) and (not when(signal > ${var.jvm_memory_pressure_threshold_critical}, lasting=%{if var.jvm_memory_pressure_lasting_duration_critical == null}None%{else}'${var.jvm_memory_pressure_lasting_duration_critical}'%{endif}, at_least=${var.jvm_memory_pressure_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_memory_pressure_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.jvm_memory_pressure_disabled_critical, var.jvm_memory_pressure_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_memory_pressure_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.jvm_memory_pressure_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_pressure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.jvm_memory_pressure_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_memory_pressure_disabled_major, var.jvm_memory_pressure_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.jvm_memory_pressure_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.jvm_memory_pressure_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_pressure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

