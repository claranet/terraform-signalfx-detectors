resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Logstash heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('node.stats.events.events.in', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "events_in_high" {
  name = format("%s %s", local.detector_name_prefix, "Logstash events in high")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('node.stats.events.events.in', filter=${module.filtering.signalflow}, rollup='delta')${var.events_in_high_aggregation_function}${var.events_in_high_transformation_function}.publish('signal')
    detect(when(signal >= ${var.events_in_high_threshold_warning}, lasting=%{if var.events_in_high_lasting_duration_warning == null}None%{else}'${var.events_in_high_lasting_duration_warning}'%{endif}, at_least=${var.events_in_high_at_least_percentage_warning}) and (not when(signal >= ${var.events_in_high_threshold_minor}, lasting=%{if var.events_in_high_lasting_duration_minor == null}None%{else}'${var.events_in_high_lasting_duration_minor}'%{endif}, at_least=${var.events_in_high_at_least_percentage_minor}))).publish('WARN')
    detect(when(signal >= ${var.events_in_high_threshold_minor}, lasting=%{if var.events_in_high_lasting_duration_minor == null}None%{else}'${var.events_in_high_lasting_duration_minor}'%{endif}, at_least=${var.events_in_high_at_least_percentage_minor})).publish('MINOR')
EOF

  rule {
    description           = "is high >= ${var.events_in_high_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.events_in_high_disabled_warning, var.events_in_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_in_high_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.events_in_high_runbook_url, var.runbook_url), "")
    tip                   = var.events_in_high_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.events_in_high_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.events_in_high_disabled_minor, var.events_in_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_in_high_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.events_in_high_runbook_url, var.runbook_url), "")
    tip                   = var.events_in_high_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "events_in_low" {
  name = format("%s %s", local.detector_name_prefix, "Logstash events in low")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('node.stats.events.events.in', filter=${module.filtering.signalflow}, rollup='delta')${var.events_in_low_aggregation_function}${var.events_in_low_transformation_function}.publish('signal')
    detect(when(signal <= ${var.events_in_low_threshold_warning}, lasting=%{if var.events_in_low_lasting_duration_warning == null}None%{else}'${var.events_in_low_lasting_duration_warning}'%{endif}, at_least=${var.events_in_low_at_least_percentage_warning}) and (not when(signal <= ${var.events_in_low_threshold_minor}, lasting=%{if var.events_in_low_lasting_duration_minor == null}None%{else}'${var.events_in_low_lasting_duration_minor}'%{endif}, at_least=${var.events_in_low_at_least_percentage_minor}))).publish('WARN')
    detect(when(signal <= ${var.events_in_low_threshold_minor}, lasting=%{if var.events_in_low_lasting_duration_minor == null}None%{else}'${var.events_in_low_lasting_duration_minor}'%{endif}, at_least=${var.events_in_low_at_least_percentage_minor})).publish('MINOR')
EOF

  rule {
    description           = "is low <= ${var.events_in_low_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.events_in_low_disabled_warning, var.events_in_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_in_low_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.events_in_low_runbook_url, var.runbook_url), "")
    tip                   = var.events_in_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low <= ${var.events_in_low_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.events_in_low_disabled_minor, var.events_in_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_in_low_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.events_in_low_runbook_url, var.runbook_url), "")
    tip                   = var.events_in_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "events_out_high" {
  name = format("%s %s", local.detector_name_prefix, "Logstash events out high")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('node.stats.events.events.out', filter=${module.filtering.signalflow}, rollup='delta')${var.events_out_high_aggregation_function}${var.events_out_high_transformation_function}.publish('signal')
    detect(when(signal >= ${var.events_out_high_threshold_warning}, lasting=%{if var.events_out_high_lasting_duration_warning == null}None%{else}'${var.events_out_high_lasting_duration_warning}'%{endif}, at_least=${var.events_out_high_at_least_percentage_warning}) and (not when(signal >= ${var.events_out_high_threshold_minor}, lasting=%{if var.events_out_high_lasting_duration_minor == null}None%{else}'${var.events_out_high_lasting_duration_minor}'%{endif}, at_least=${var.events_out_high_at_least_percentage_minor}))).publish('WARN')
    detect(when(signal >= ${var.events_out_high_threshold_minor}, lasting=%{if var.events_out_high_lasting_duration_minor == null}None%{else}'${var.events_out_high_lasting_duration_minor}'%{endif}, at_least=${var.events_out_high_at_least_percentage_minor})).publish('MINOR')
EOF

  rule {
    description           = "is high >= ${var.events_out_high_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.events_out_high_disabled_warning, var.events_out_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_out_high_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.events_out_high_runbook_url, var.runbook_url), "")
    tip                   = var.events_out_high_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.events_out_high_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.events_out_high_disabled_minor, var.events_out_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_out_high_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.events_out_high_runbook_url, var.runbook_url), "")
    tip                   = var.events_out_high_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "events_out_low" {
  name = format("%s %s", local.detector_name_prefix, "Logstash events out low")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('node.stats.events.events.out', filter=${module.filtering.signalflow}, rollup='delta')${var.events_out_low_aggregation_function}${var.events_out_low_transformation_function}.publish('signal')
    detect(when(signal <= ${var.events_out_low_threshold_warning}, lasting=%{if var.events_out_low_lasting_duration_warning == null}None%{else}'${var.events_out_low_lasting_duration_warning}'%{endif}, at_least=${var.events_out_low_at_least_percentage_warning}) and (not when(signal <= ${var.events_out_low_threshold_minor}, lasting=%{if var.events_out_low_lasting_duration_minor == null}None%{else}'${var.events_out_low_lasting_duration_minor}'%{endif}, at_least=${var.events_out_low_at_least_percentage_minor}))).publish('WARN')
    detect(when(signal <= ${var.events_out_low_threshold_minor}, lasting=%{if var.events_out_low_lasting_duration_minor == null}None%{else}'${var.events_out_low_lasting_duration_minor}'%{endif}, at_least=${var.events_out_low_at_least_percentage_minor})).publish('MINOR')
EOF

  rule {
    description           = "is low <= ${var.events_out_low_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.events_out_low_disabled_warning, var.events_out_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_out_low_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.events_out_low_runbook_url, var.runbook_url), "")
    tip                   = var.events_out_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low <= ${var.events_out_low_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.events_out_low_disabled_minor, var.events_out_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_out_low_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.events_out_low_runbook_url, var.runbook_url), "")
    tip                   = var.events_out_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "cpu_percent" {
  name = format("%s %s", local.detector_name_prefix, "Logstash cpu percent")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('node.stats.process.process.cpu.percent', filter=${module.filtering.signalflow})${var.cpu_percent_aggregation_function}${var.cpu_percent_transformation_function}.publish('signal')
    detect(when(signal >= ${var.cpu_percent_threshold_warning}, lasting=%{if var.cpu_percent_lasting_duration_warning == null}None%{else}'${var.cpu_percent_lasting_duration_warning}'%{endif}, at_least=${var.cpu_percent_at_least_percentage_warning})).publish('WARN')
    detect(when(signal >= ${var.cpu_percent_threshold_minor}, lasting=%{if var.cpu_percent_lasting_duration_minor == null}None%{else}'${var.cpu_percent_lasting_duration_minor}'%{endif}, at_least=${var.cpu_percent_at_least_percentage_minor})).publish('MINOR')
EOF

  rule {
    description           = "is high >= ${var.cpu_percent_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cpu_percent_disabled_warning, var.cpu_percent_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_percent_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.cpu_percent_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_percent_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.cpu_percent_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.cpu_percent_disabled_minor, var.cpu_percent_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_percent_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.cpu_percent_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_percent_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "queued_events" {
  name = format("%s %s", local.detector_name_prefix, "Logstash queued events")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('node.stats.pipelines.queue.events_count', filter=${module.filtering.signalflow}, rollup='latest')${var.queued_events_aggregation_function}${var.queued_events_transformation_function}.publish('signal')
    detect(when(signal >= ${var.queued_events_threshold_warning}, lasting=%{if var.queued_events_lasting_duration_warning == null}None%{else}'${var.queued_events_lasting_duration_warning}'%{endif}, at_least=${var.queued_events_at_least_percentage_warning}) and (not when(signal >= ${var.queued_events_threshold_minor}, lasting=%{if var.queued_events_lasting_duration_minor == null}None%{else}'${var.queued_events_lasting_duration_minor}'%{endif}, at_least=${var.queued_events_at_least_percentage_minor}))).publish('WARN')
    detect(when(signal >= ${var.queued_events_threshold_minor}, lasting=%{if var.queued_events_lasting_duration_minor == null}None%{else}'${var.queued_events_lasting_duration_minor}'%{endif}, at_least=${var.queued_events_at_least_percentage_minor})).publish('MINOR')
EOF

  rule {
    description           = "is high >= ${var.queued_events_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.queued_events_disabled_warning, var.queued_events_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.queued_events_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.queued_events_runbook_url, var.runbook_url), "")
    tip                   = var.queued_events_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.queued_events_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.queued_events_disabled_minor, var.queued_events_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.queued_events_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.queued_events_runbook_url, var.runbook_url), "")
    tip                   = var.queued_events_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "queued_disk" {
  name = format("%s %s", local.detector_name_prefix, "Logstash queued disk")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    disk = data('node.stats.pipelines.queue.queue_size_in_bytes', filter=${module.filtering.signalflow}, rollup='latest')${var.queued_disk_aggregation_function}${var.queued_disk_transformation_function}
    signal = (disk / 1000000).publish('signal')
    detect(when(signal >= ${var.queued_disk_threshold_warning}, lasting=%{if var.queued_disk_lasting_duration_warning == null}None%{else}'${var.queued_disk_lasting_duration_warning}'%{endif}, at_least=${var.queued_disk_at_least_percentage_warning}) and (not when(signal >= ${var.queued_disk_threshold_minor}, lasting=%{if var.queued_disk_lasting_duration_minor == null}None%{else}'${var.queued_disk_lasting_duration_minor}'%{endif}, at_least=${var.queued_disk_at_least_percentage_minor}))).publish('WARN')
    detect(when(signal >= ${var.queued_disk_threshold_minor}, lasting=%{if var.queued_disk_lasting_duration_minor == null}None%{else}'${var.queued_disk_lasting_duration_minor}'%{endif}, at_least=${var.queued_disk_at_least_percentage_minor})).publish('MINOR')
EOF

  rule {
    description           = "is high >= ${var.queued_disk_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.queued_disk_disabled_warning, var.queued_disk_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.queued_disk_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.queued_disk_runbook_url, var.runbook_url), "")
    tip                   = var.queued_disk_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.queued_disk_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.queued_disk_disabled_minor, var.queued_disk_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.queued_disk_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.queued_disk_runbook_url, var.runbook_url), "")
    tip                   = var.queued_disk_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

