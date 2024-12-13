resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Dnsmasq heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('dnsmasq_cachesize', filter=%{if var.heartbeat_exclude_not_running_vm}${local.not_running_vm_filters} and %{endif}${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "dnsmasq_hits" {
  name = format("%s %s", local.detector_name_prefix, "Dnsmasq hits")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('dnsmasq_hits', filter=${module.filtering.signalflow})${var.dnsmasq_hits_aggregation_function}${var.dnsmasq_hits_transformation_function}.publish('signal')
    detect(when(signal <= ${var.dnsmasq_hits_threshold_critical}%{if var.dnsmasq_hits_lasting_duration_critical != null}, lasting='${var.dnsmasq_hits_lasting_duration_critical}', at_least=${var.dnsmasq_hits_at_least_percentage_critical}%{endif})).publish('CRIT')
EOF

  rule {
    description           = "is too low <= ${var.dnsmasq_hits_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.dnsmasq_hits_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dnsmasq_hits_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.dnsmasq_hits_runbook_url, var.runbook_url), "")
    tip                   = var.dnsmasq_hits_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.dnsmasq_hits_max_delay
}

resource "signalfx_detector" "dnsmasq_hit_rate" {
  name = format("%s %s", local.detector_name_prefix, "Dnsmasq hit rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('dnsmasq_hits', filter=${module.filtering.signalflow})${var.dnsmasq_hit_rate_aggregation_function}${var.dnsmasq_hit_rate_transformation_function}
    B = data('dnsmasq_misses', filter=${module.filtering.signalflow})${var.dnsmasq_hit_rate_aggregation_function}${var.dnsmasq_hit_rate_transformation_function}
    signal = (A/(A+B)).fill(0).scale(100).publish('signal')
    detect(when(signal < ${var.dnsmasq_hit_rate_threshold_minor}%{if var.dnsmasq_hit_rate_lasting_duration_minor != null}, lasting='${var.dnsmasq_hit_rate_lasting_duration_minor}', at_least=${var.dnsmasq_hit_rate_at_least_percentage_minor}%{endif}) and (not when(signal <= ${var.dnsmasq_hit_rate_threshold_major}%{if var.dnsmasq_hit_rate_lasting_duration_major != null}, lasting='${var.dnsmasq_hit_rate_lasting_duration_major}', at_least=${var.dnsmasq_hit_rate_at_least_percentage_major}%{endif}))).publish('MINOR')
    detect(when(signal <= ${var.dnsmasq_hit_rate_threshold_major}%{if var.dnsmasq_hit_rate_lasting_duration_major != null}, lasting='${var.dnsmasq_hit_rate_lasting_duration_major}', at_least=${var.dnsmasq_hit_rate_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.dnsmasq_hit_rate_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.dnsmasq_hit_rate_disabled_minor, var.dnsmasq_hit_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dnsmasq_hit_rate_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.dnsmasq_hit_rate_runbook_url, var.runbook_url), "")
    tip                   = var.dnsmasq_hit_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low <= ${var.dnsmasq_hit_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.dnsmasq_hit_rate_disabled_major, var.dnsmasq_hit_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.dnsmasq_hit_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.dnsmasq_hit_rate_runbook_url, var.runbook_url), "")
    tip                   = var.dnsmasq_hit_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.dnsmasq_hit_rate_max_delay
}

