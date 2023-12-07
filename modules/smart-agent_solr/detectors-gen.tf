resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Apache Solr heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('counter.solr.http_requests', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "errors" {
  name = format("%s %s", local.detector_name_prefix, "Apache Solr errors count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('counter.solr.zookeeper_errors', filter=${module.filtering.signalflow})${var.errors_aggregation_function}${var.errors_transformation_function}.publish('signal')
    detect(when(signal >= ${var.errors_threshold_critical}%{if var.errors_lasting_duration_critical != null}, lasting='${var.errors_lasting_duration_critical}', at_least=${var.errors_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal >= ${var.errors_threshold_major}%{if var.errors_lasting_duration_major != null}, lasting='${var.errors_lasting_duration_major}', at_least=${var.errors_at_least_percentage_major}%{endif}) and (not when(signal >= ${var.errors_threshold_critical}%{if var.errors_lasting_duration_critical != null}, lasting='${var.errors_lasting_duration_critical}', at_least=${var.errors_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.errors_disabled_critical, var.errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.errors_runbook_url, var.runbook_url), "")
    tip                   = var.errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.errors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.errors_disabled_major, var.errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.errors_runbook_url, var.runbook_url), "")
    tip                   = var.errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.errors_max_delay
}

resource "signalfx_detector" "searcher_warmup_time" {
  name = format("%s %s", local.detector_name_prefix, "Apache Solr searcher warmup time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.solr.searcher_warmup', filter=${module.filtering.signalflow})${var.searcher_warmup_time_aggregation_function}${var.searcher_warmup_time_transformation_function}.publish('signal')
    detect(when(signal >= ${var.searcher_warmup_time_threshold_critical}%{if var.searcher_warmup_time_lasting_duration_critical != null}, lasting='${var.searcher_warmup_time_lasting_duration_critical}', at_least=${var.searcher_warmup_time_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal >= ${var.searcher_warmup_time_threshold_major}%{if var.searcher_warmup_time_lasting_duration_major != null}, lasting='${var.searcher_warmup_time_lasting_duration_major}', at_least=${var.searcher_warmup_time_at_least_percentage_major}%{endif}) and (not when(signal >= ${var.searcher_warmup_time_threshold_critical}%{if var.searcher_warmup_time_lasting_duration_critical != null}, lasting='${var.searcher_warmup_time_lasting_duration_critical}', at_least=${var.searcher_warmup_time_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.searcher_warmup_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.searcher_warmup_time_disabled_critical, var.searcher_warmup_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.searcher_warmup_time_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.searcher_warmup_time_runbook_url, var.runbook_url), "")
    tip                   = var.searcher_warmup_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.searcher_warmup_time_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.searcher_warmup_time_disabled_major, var.searcher_warmup_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.searcher_warmup_time_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.searcher_warmup_time_runbook_url, var.runbook_url), "")
    tip                   = var.searcher_warmup_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.searcher_warmup_time_max_delay
}

