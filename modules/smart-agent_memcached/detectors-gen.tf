resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Memcached heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('memcached_items.current', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.heartbeat_max_delay
}

resource "signalfx_detector" "memcached_max_conn" {
  name = format("%s %s", local.detector_name_prefix, "Memcached max conn")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('total_events.listen_disabled', filter=${module.filtering.signalflow}, rollup='delta')${var.memcached_max_conn_aggregation_function}${var.memcached_max_conn_transformation_function}.publish('signal')
    detect(when(signal > ${var.memcached_max_conn_threshold_critical}%{if var.memcached_max_conn_lasting_duration_critical != null}, lasting='${var.memcached_max_conn_lasting_duration_critical}', at_least=${var.memcached_max_conn_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.memcached_max_conn_threshold_major}%{if var.memcached_max_conn_lasting_duration_major != null}, lasting='${var.memcached_max_conn_lasting_duration_major}', at_least=${var.memcached_max_conn_at_least_percentage_major}%{endif}) and (not when(signal > ${var.memcached_max_conn_threshold_critical}%{if var.memcached_max_conn_lasting_duration_critical != null}, lasting='${var.memcached_max_conn_lasting_duration_critical}', at_least=${var.memcached_max_conn_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memcached_max_conn_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memcached_max_conn_disabled_critical, var.memcached_max_conn_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memcached_max_conn_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memcached_max_conn_runbook_url, var.runbook_url), "")
    tip                   = var.memcached_max_conn_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memcached_max_conn_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memcached_max_conn_disabled_major, var.memcached_max_conn_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memcached_max_conn_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memcached_max_conn_runbook_url, var.runbook_url), "")
    tip                   = var.memcached_max_conn_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memcached_max_conn_max_delay
}

resource "signalfx_detector" "memcached_hit_ratio" {
  name = format("%s %s", local.detector_name_prefix, "Memcached hit ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('memcached_ops.hits', filter=${module.filtering.signalflow})${var.memcached_hit_ratio_aggregation_function}${var.memcached_hit_ratio_transformation_function}
    B = data('memcached_ops.misses', filter=${module.filtering.signalflow})${var.memcached_hit_ratio_aggregation_function}${var.memcached_hit_ratio_transformation_function}
    signal = (A / (A+B) * 100).publish('signal')
    detect(when(signal < ${var.memcached_hit_ratio_threshold_major}%{if var.memcached_hit_ratio_lasting_duration_major != null}, lasting='${var.memcached_hit_ratio_lasting_duration_major}', at_least=${var.memcached_hit_ratio_at_least_percentage_major}%{endif})).publish('MAJOR')
    detect(when(signal < ${var.memcached_hit_ratio_threshold_minor}%{if var.memcached_hit_ratio_lasting_duration_minor != null}, lasting='${var.memcached_hit_ratio_lasting_duration_minor}', at_least=${var.memcached_hit_ratio_at_least_percentage_minor}%{endif}) and (not when(signal < ${var.memcached_hit_ratio_threshold_major}%{if var.memcached_hit_ratio_lasting_duration_major != null}, lasting='${var.memcached_hit_ratio_lasting_duration_major}', at_least=${var.memcached_hit_ratio_at_least_percentage_major}%{endif}))).publish('MINOR')
EOF

  rule {
    description           = "is too low < ${var.memcached_hit_ratio_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memcached_hit_ratio_disabled_major, var.memcached_hit_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memcached_hit_ratio_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memcached_hit_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.memcached_hit_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.memcached_hit_ratio_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.memcached_hit_ratio_disabled_minor, var.memcached_hit_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memcached_hit_ratio_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.memcached_hit_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.memcached_hit_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memcached_hit_ratio_max_delay
}

