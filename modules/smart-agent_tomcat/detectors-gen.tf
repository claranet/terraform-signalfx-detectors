resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Tomcat heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('gauge.tomcat.ThreadPool.maxThreads', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "average_processing_time" {
  name = format("%s %s", local.detector_name_prefix, "Tomcat average processing time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('counter.tomcat.GlobalRequestProcessor.processingTime', filter=${module.filtering.signalflow}, rollup='delta')${var.average_processing_time_aggregation_function}${var.average_processing_time_transformation_function}
    B = data('counter.tomcat.GlobalRequestProcessor.requestCount', filter=${module.filtering.signalflow}, rollup='delta')${var.average_processing_time_aggregation_function}${var.average_processing_time_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.average_processing_time_threshold_critical}%{if var.average_processing_time_lasting_duration_critical != null}, lasting='${var.average_processing_time_lasting_duration_critical}', at_least=${var.average_processing_time_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.average_processing_time_threshold_major}%{if var.average_processing_time_lasting_duration_major != null}, lasting='${var.average_processing_time_lasting_duration_major}', at_least=${var.average_processing_time_at_least_percentage_major}%{endif}) and (not when(signal > ${var.average_processing_time_threshold_critical}%{if var.average_processing_time_lasting_duration_critical != null}, lasting='${var.average_processing_time_lasting_duration_critical}', at_least=${var.average_processing_time_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.average_processing_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.average_processing_time_disabled_critical, var.average_processing_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.average_processing_time_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.average_processing_time_runbook_url, var.runbook_url), "")
    tip                   = var.average_processing_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.average_processing_time_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.average_processing_time_disabled_major, var.average_processing_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.average_processing_time_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.average_processing_time_runbook_url, var.runbook_url), "")
    tip                   = var.average_processing_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.average_processing_time_max_delay
}

resource "signalfx_detector" "busy_threads_percentage" {
  name = format("%s %s", local.detector_name_prefix, "Tomcat busy threads percentage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('gauge.tomcat.ThreadPool.currentThreadsBusy', filter=${module.filtering.signalflow})${var.busy_threads_percentage_aggregation_function}${var.busy_threads_percentage_transformation_function}
    B = data('gauge.tomcat.ThreadPool.maxThreads', filter=${module.filtering.signalflow})${var.busy_threads_percentage_aggregation_function}${var.busy_threads_percentage_transformation_function}
    signal = (A/B).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.busy_threads_percentage_threshold_critical}%{if var.busy_threads_percentage_lasting_duration_critical != null}, lasting='${var.busy_threads_percentage_lasting_duration_critical}', at_least=${var.busy_threads_percentage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.busy_threads_percentage_threshold_major}%{if var.busy_threads_percentage_lasting_duration_major != null}, lasting='${var.busy_threads_percentage_lasting_duration_major}', at_least=${var.busy_threads_percentage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.busy_threads_percentage_threshold_critical}%{if var.busy_threads_percentage_lasting_duration_critical != null}, lasting='${var.busy_threads_percentage_lasting_duration_critical}', at_least=${var.busy_threads_percentage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.busy_threads_percentage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.busy_threads_percentage_disabled_critical, var.busy_threads_percentage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.busy_threads_percentage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.busy_threads_percentage_runbook_url, var.runbook_url), "")
    tip                   = var.busy_threads_percentage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.busy_threads_percentage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.busy_threads_percentage_disabled_major, var.busy_threads_percentage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.busy_threads_percentage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.busy_threads_percentage_runbook_url, var.runbook_url), "")
    tip                   = var.busy_threads_percentage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.busy_threads_percentage_max_delay
}

