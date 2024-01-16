resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Varnish heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('system.type', 'prometheus-exporter')
    signal = data('varnish_main_threads', filter=${local.not_running_vm_filters} and base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "backend_failed" {
  name = format("%s %s", local.detector_name_prefix, "Varnish backend failed")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('system.type', 'prometheus-exporter')
    signal = data('varnish_backend_fail', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.backend_failed_aggregation_function}${var.backend_failed_transformation_function}.publish('signal')
    detect(when(signal > ${var.backend_failed_threshold_critical}%{if var.backend_failed_lasting_duration_critical != null}, lasting='${var.backend_failed_lasting_duration_critical}', at_least=${var.backend_failed_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.backend_failed_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_failed_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_failed_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backend_failed_runbook_url, var.runbook_url), "")
    tip                   = var.backend_failed_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backend_failed_max_delay
}

resource "signalfx_detector" "thread_number" {
  name = format("%s %s", local.detector_name_prefix, "Varnish thread number")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('system.type', 'prometheus-exporter')
    signal = data('varnish_main_threads', filter=base_filtering and ${module.filtering.signalflow})${var.thread_number_aggregation_function}${var.thread_number_transformation_function}.publish('signal')
    detect(when(signal < ${var.thread_number_threshold_critical}%{if var.thread_number_lasting_duration_critical != null}, lasting='${var.thread_number_lasting_duration_critical}', at_least=${var.thread_number_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.thread_number_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.thread_number_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.thread_number_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.thread_number_runbook_url, var.runbook_url), "")
    tip                   = var.thread_number_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.thread_number_max_delay
}

resource "signalfx_detector" "dropped_sessions" {
  name = format("%s %s", local.detector_name_prefix, "Varnish dropped sessions")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('system.type', 'prometheus-exporter')
    signal = data('varnish_main_sessions', filter=base_filtering and filter('type', 'dropped') and ${module.filtering.signalflow}, rollup='delta')${var.dropped_sessions_aggregation_function}${var.dropped_sessions_transformation_function}.publish('signal')
    detect(when(signal > ${var.dropped_sessions_threshold_critical}%{if var.dropped_sessions_lasting_duration_critical != null}, lasting='${var.dropped_sessions_lasting_duration_critical}', at_least=${var.dropped_sessions_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.dropped_sessions_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dropped_sessions_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dropped_sessions_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.dropped_sessions_runbook_url, var.runbook_url), "")
    tip                   = var.dropped_sessions_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.dropped_sessions_max_delay
}

resource "signalfx_detector" "hit_rate" {
  name = format("%s %s", local.detector_name_prefix, "Varnish hit rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('system.type', 'prometheus-exporter')
    A = data('varnish_main_cache_hit', filter=base_filtering and ${module.filtering.signalflow})${var.hit_rate_aggregation_function}${var.hit_rate_transformation_function}
    B = data('varnish_main_cache_miss', filter=base_filtering and ${module.filtering.signalflow})${var.hit_rate_aggregation_function}${var.hit_rate_transformation_function}
    signal = (A/(A+B)).fill(0).scale(100).publish('signal')
    detect(when(signal < ${var.hit_rate_threshold_minor}%{if var.hit_rate_lasting_duration_minor != null}, lasting='${var.hit_rate_lasting_duration_minor}', at_least=${var.hit_rate_at_least_percentage_minor}%{endif}) and (not when(signal <= ${var.hit_rate_threshold_major}%{if var.hit_rate_lasting_duration_major != null}, lasting='${var.hit_rate_lasting_duration_major}', at_least=${var.hit_rate_at_least_percentage_major}%{endif}))).publish('MINOR')
    detect(when(signal <= ${var.hit_rate_threshold_major}%{if var.hit_rate_lasting_duration_major != null}, lasting='${var.hit_rate_lasting_duration_major}', at_least=${var.hit_rate_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.hit_rate_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.hit_rate_disabled_minor, var.hit_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.hit_rate_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.hit_rate_runbook_url, var.runbook_url), "")
    tip                   = var.hit_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low <= ${var.hit_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.hit_rate_disabled_major, var.hit_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.hit_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.hit_rate_runbook_url, var.runbook_url), "")
    tip                   = var.hit_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.hit_rate_max_delay
}

resource "signalfx_detector" "memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "Varnish memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('system.type', 'prometheus-exporter')
    A = data('varnish_sma_g_bytes', filter=base_filtering and filter('type', 's0') and ${module.filtering.signalflow})${var.memory_usage_aggregation_function}${var.memory_usage_transformation_function}
    B = data('varnish_sma_g_space', filter=base_filtering and filter('type', 's0') and ${module.filtering.signalflow})${var.memory_usage_aggregation_function}${var.memory_usage_transformation_function}
    signal = (A / (A+B)).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.memory_usage_threshold_critical}%{if var.memory_usage_lasting_duration_critical != null}, lasting='${var.memory_usage_lasting_duration_critical}', at_least=${var.memory_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.memory_usage_threshold_major}%{if var.memory_usage_lasting_duration_major != null}, lasting='${var.memory_usage_lasting_duration_major}', at_least=${var.memory_usage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.memory_usage_threshold_critical}%{if var.memory_usage_lasting_duration_critical != null}, lasting='${var.memory_usage_lasting_duration_critical}', at_least=${var.memory_usage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_usage_disabled_critical, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_usage_disabled_major, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_usage_max_delay
}

