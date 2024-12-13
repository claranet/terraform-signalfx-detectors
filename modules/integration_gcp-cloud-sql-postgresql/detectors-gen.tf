resource "signalfx_detector" "replication_lag" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud SQL PostgreSQL replication lag")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('database/postgresql/replication/replica_byte_lag', filter=${module.filtering.signalflow})${var.replication_lag_aggregation_function}${var.replication_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replication_lag_threshold_critical}%{if var.replication_lag_lasting_duration_critical != null}, lasting='${var.replication_lag_lasting_duration_critical}', at_least=${var.replication_lag_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.replication_lag_threshold_major}%{if var.replication_lag_lasting_duration_major != null}, lasting='${var.replication_lag_lasting_duration_major}', at_least=${var.replication_lag_at_least_percentage_major}%{endif}) and (not when(signal > ${var.replication_lag_threshold_critical}%{if var.replication_lag_lasting_duration_critical != null}, lasting='${var.replication_lag_lasting_duration_critical}', at_least=${var.replication_lag_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replication_lag_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.replication_lag_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.replication_lag_disabled_major, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.replication_lag_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.replication_lag_runbook_url, var.runbook_url), "")
    tip                   = var.replication_lag_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.replication_lag_max_delay
}

