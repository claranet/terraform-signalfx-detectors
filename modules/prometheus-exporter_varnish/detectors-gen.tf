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
    detect(when(signal > ${var.backend_failed_threshold_critical}, lasting=%{if var.backend_failed_lasting_duration_critical == null}None%{else}'${var.backend_failed_lasting_duration_critical}'%{endif}, at_least=${var.backend_failed_at_least_percentage_critical})).publish('CRIT')
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
    detect(when(signal < ${var.thread_number_threshold_critical}, lasting=%{if var.thread_number_lasting_duration_critical == null}None%{else}'${var.thread_number_lasting_duration_critical}'%{endif}, at_least=${var.thread_number_at_least_percentage_critical})).publish('CRIT')
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

