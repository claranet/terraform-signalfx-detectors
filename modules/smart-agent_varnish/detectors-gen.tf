resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Varnish heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('varnish.threads', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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
    base_filtering = filter('plugin', 'telegraf/varnish')
    signal = data('varnish.backend_fail', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.backend_failed_aggregation_function}${var.backend_failed_transformation_function}.publish('signal')
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

resource "signalfx_detector" "threads_number" {
  name = format("%s %s", local.detector_name_prefix, "Varnish threads number")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'telegraf/varnish')
    signal = data('varnish.threads', filter=base_filtering and ${module.filtering.signalflow})${var.threads_number_aggregation_function}${var.threads_number_transformation_function}.publish('signal')
    detect(when(signal < ${var.threads_number_threshold_critical}%{if var.threads_number_lasting_duration_critical != null}, lasting='${var.threads_number_lasting_duration_critical}', at_least=${var.threads_number_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.threads_number_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.threads_number_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.threads_number_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.threads_number_runbook_url, var.runbook_url), "")
    tip                   = var.threads_number_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.threads_number_max_delay
}

resource "signalfx_detector" "session_dropped" {
  name = format("%s %s", local.detector_name_prefix, "Varnish session dropped")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'telegraf/varnish')
    signal = data('varnish.sess_dropped', filter=base_filtering and ${module.filtering.signalflow})${var.session_dropped_aggregation_function}${var.session_dropped_transformation_function}.publish('signal')
    detect(when(signal > ${var.session_dropped_threshold_critical}%{if var.session_dropped_lasting_duration_critical != null}, lasting='${var.session_dropped_lasting_duration_critical}', at_least=${var.session_dropped_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.session_dropped_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.session_dropped_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.session_dropped_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.session_dropped_runbook_url, var.runbook_url), "")
    tip                   = var.session_dropped_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.session_dropped_max_delay
}

resource "signalfx_detector" "cache_hit_rate" {
  name = format("%s %s", local.detector_name_prefix, "Varnish hit rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'telegraf/varnish')
    A = data('varnish.cache_hit', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.cache_hit_rate_aggregation_function}${var.cache_hit_rate_transformation_function}
    B = data('varnish.cache_miss', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta')${var.cache_hit_rate_aggregation_function}${var.cache_hit_rate_transformation_function}
    signal = (A/(A+B)).fill(0).scale(100).publish('signal')
    detect(when(signal < ${var.cache_hit_rate_threshold_minor}%{if var.cache_hit_rate_lasting_duration_minor != null}, lasting='${var.cache_hit_rate_lasting_duration_minor}', at_least=${var.cache_hit_rate_at_least_percentage_minor}%{endif}) and (not when(signal < ${var.cache_hit_rate_threshold_major}%{if var.cache_hit_rate_lasting_duration_major != null}, lasting='${var.cache_hit_rate_lasting_duration_major}', at_least=${var.cache_hit_rate_at_least_percentage_major}%{endif}))).publish('MINOR')
    detect(when(signal < ${var.cache_hit_rate_threshold_major}%{if var.cache_hit_rate_lasting_duration_major != null}, lasting='${var.cache_hit_rate_lasting_duration_major}', at_least=${var.cache_hit_rate_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.cache_hit_rate_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.cache_hit_rate_disabled_minor, var.cache_hit_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cache_hit_rate_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.cache_hit_rate_runbook_url, var.runbook_url), "")
    tip                   = var.cache_hit_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.cache_hit_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cache_hit_rate_disabled_major, var.cache_hit_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cache_hit_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cache_hit_rate_runbook_url, var.runbook_url), "")
    tip                   = var.cache_hit_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cache_hit_rate_max_delay
}

resource "signalfx_detector" "memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "Varnish memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'telegraf/varnish')
    A = data('varnish.s0.g_bytes', filter=base_filtering and ${module.filtering.signalflow})${var.memory_usage_aggregation_function}${var.memory_usage_transformation_function}
    B = data('varnish.s0.g_space', filter=base_filtering and ${module.filtering.signalflow})${var.memory_usage_aggregation_function}${var.memory_usage_transformation_function}
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

