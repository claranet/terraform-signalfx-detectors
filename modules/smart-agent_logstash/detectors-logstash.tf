# Events in
resource "signalfx_detector" "events_in_high" {
  name = format("%s %s", local.detector_name_prefix, "Logstash events in high")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('${var.events_in_metric_name}', filter=filter('plugin','logstash') and ${module.filtering.signalflow}, rollup='delta')${var.events_in_high_aggregation_function}${var.events_in_high_transformation_function}.publish('signal')
    detect(when(signal > ${var.events_in_high_threshold_critical},lasting='${var.events_in_high_threshold_critical_lasting}')).publish('CRIT')
    detect(when(signal > ${var.events_in_high_threshold_major},lasting='${var.events_in_high_threshold_major_lasting}') and when(signal <= ${var.events_in_high_threshold_critical},lasting='${var.events_in_high_threshold_critical_lasting}')).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.events_in_high_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.events_in_high_disabled_critical, var.events_in_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_in_high_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.events_in_high_runbook_url, var.runbook_url), "")
    tip                   = var.events_in_high_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is high > ${var.events_in_high_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.events_in_high_disabled_major, var.events_in_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_in_high_notifications, "major", []), var.notifications.major)
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
    signal = data('${var.events_in_metric_name}', filter=filter('plugin','logstash') and ${module.filtering.signalflow}, rollup='delta')${var.events_in_low_aggregation_function}${var.events_in_low_transformation_function}.publish('signal')
    detect(when(signal <= ${var.events_in_low_threshold_critical},lasting='${var.events_in_low_threshold_critical_lasting}')).publish('CRIT')
    detect(when(signal < ${var.events_in_low_threshold_major},lasting='${var.events_in_low_threshold_major_lasting}') and when(signal > ${var.events_in_low_threshold_critical},lasting='${var.events_in_low_threshold_critical_lasting}')).publish('MAJOR')
EOF

  rule {
    description           = "is too low <= ${var.events_in_low_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.events_in_low_disabled_critical, var.events_in_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_in_low_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.events_in_low_runbook_url, var.runbook_url), "")
    tip                   = var.events_in_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is low < ${var.events_in_low_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.events_in_low_disabled_major, var.events_in_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_in_low_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.events_in_low_runbook_url, var.runbook_url), "")
    tip                   = var.events_in_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

# Events out
resource "signalfx_detector" "events_out_high" {
  name = format("%s %s", local.detector_name_prefix, "Logstash events out high")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('${var.events_out_metric_name}', filter=filter('plugin','logstash') and ${module.filtering.signalflow}, rollup='delta')${var.events_out_high_aggregation_function}${var.events_out_high_transformation_function}.publish('signal')
    detect(when(signal > ${var.events_out_high_threshold_critical},lasting='${var.events_out_high_threshold_critical_lasting}')).publish('CRIT')
    detect(when(signal > ${var.events_out_high_threshold_major},lasting='${var.events_out_high_threshold_major_lasting}') and when(signal <= ${var.events_out_high_threshold_critical},lasting='${var.events_out_high_threshold_critical_lasting}')).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.events_out_high_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.events_out_high_disabled_critical, var.events_out_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_out_high_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.events_out_high_runbook_url, var.runbook_url), "")
    tip                   = var.events_out_high_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is high > ${var.events_out_high_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.events_out_high_disabled_major, var.events_out_high_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_out_high_notifications, "major", []), var.notifications.major)
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
    signal = data('${var.events_out_metric_name}', filter=filter('plugin','logstash') and ${module.filtering.signalflow}, rollup='delta')${var.events_out_low_aggregation_function}${var.events_out_low_transformation_function}.publish('signal')
    detect(when(signal <= ${var.events_out_low_threshold_critical},lasting='${var.events_out_low_threshold_critical_lasting}')).publish('CRIT')
    detect(when(signal < ${var.events_out_low_threshold_major},lasting='${var.events_out_low_threshold_major_lasting}') and when(signal >= ${var.events_out_low_threshold_critical},lasting='${var.events_out_low_threshold_critical_lasting}')).publish('MAJOR')
EOF

  rule {
    description           = "is too low <= ${var.events_out_low_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.events_out_low_disabled_critical, var.events_out_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_out_low_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.events_out_low_runbook_url, var.runbook_url), "")
    tip                   = var.events_out_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is low < ${var.events_out_low_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.events_out_low_disabled_major, var.events_out_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.events_out_low_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.events_out_low_runbook_url, var.runbook_url), "")
    tip                   = var.events_out_low_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "cpu_usage_percent" {
  name = format("%s %s", local.detector_name_prefix, "Logstash cpu usage percent")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('node.stats.process.process.cpu.percent', filter=filter('plugin','logstash') and ${module.filtering.signalflow})${var.cpu_usage_percent_aggregation_function}${var.cpu_usage_percent_transformation_function}.publish('signal')
    detect(when(signal >= ${var.cpu_usage_percent_threshold_critical},lasting='${var.cpu_usage_percent_threshold_critical_lasting}')).publish('CRIT')
    detect(when(signal > ${var.cpu_usage_percent_threshold_major},lasting='${var.cpu_usage_percent_threshold_major_lasting}') and when(signal < ${var.cpu_usage_percent_threshold_critical},lasting='${var.cpu_usage_percent_threshold_critical_lasting}')).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.cpu_usage_percent_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_usage_percent_disabled_critical, var.cpu_usage_percent_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_usage_percent_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.cpu_usage_percent_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_percent_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is high > ${var.cpu_usage_percent_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_usage_percent_disabled_major, var.cpu_usage_percent_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_usage_percent_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.cpu_usage_percent_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_percent_tip
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
    signal = data('node.stats.pipelines.queue.events_count', filter=filter('plugin','logstash') and ${module.filtering.signalflow})${var.queued_events_aggregation_function}${var.queued_events_transformation_function}.publish('signal')
    detect(when(signal >= ${var.queued_events_threshold_critical},lasting='${var.queued_events_threshold_critical_lasting}')).publish('CRIT')
    detect(when(signal > ${var.queued_events_threshold_major},lasting='${var.queued_events_threshold_major_lasting}') and when(signal < ${var.queued_events_threshold_critical},lasting='${var.queued_events_threshold_critical_lasting}')).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.queued_events_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.queued_events_disabled_critical, var.queued_events_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.queued_events_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.queued_events_runbook_url, var.runbook_url), "")
    tip                   = var.queued_events_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is high > ${var.queued_events_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.queued_events_disabled_major, var.queued_events_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.queued_events_notifications, "major", []), var.notifications.major)
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
    signal = data('node.stats.pipelines.queue.queue_size_in_bytes', filter=filter('plugin','logstash') and ${module.filtering.signalflow})${var.queued_disk_aggregation_function}${var.queued_disk_transformation_function}.publish('signal')
    detect(when(signal >= ${var.queued_disk_threshold_critical},lasting='${var.queued_disk_threshold_critical_lasting}')).publish('CRIT')
    detect(when(signal > ${var.queued_disk_threshold_major},lasting='${var.queued_disk_threshold_major_lasting}') and when(signal < ${var.queued_disk_threshold_critical},lasting='${var.queued_disk_threshold_critical_lasting}')).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.queued_disk_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.queued_disk_disabled_critical, var.queued_disk_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.queued_disk_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.queued_disk_runbook_url, var.runbook_url), "")
    tip                   = var.queued_disk_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is high > ${var.queued_disk_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.queued_disk_disabled_major, var.queued_disk_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.queued_disk_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.queued_disk_runbook_url, var.runbook_url), "")
    tip                   = var.queued_disk_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

