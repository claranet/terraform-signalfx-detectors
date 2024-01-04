resource "signalfx_detector" "zookeeper-health" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper zookeeper-health")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.zk_service_health', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.zookeeper-health_aggregation_function}.publish('signal')
    detect(when(signal != ${var.zookeeper-health_threshold_critical}, lasting=%{if var.zookeeper-health_lasting_duration_critical == null}None%{else}'${var.zookeeper-health_lasting_duration_critical}'%{endif}, at_least=${var.zookeeper-health_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not running != ${var.zookeeper-health_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.zookeeper-health_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.zookeeper-health_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.zookeeper-health_runbook_url, var.runbook_url), "")
    tip                   = var.zookeeper-health_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.zookeeper-health_max_delay
}

resource "signalfx_detector" "zookeeper-latency" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper zookeeper-latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.zk_avg_latency', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.zookeeper-latency_aggregation_function}.publish('signal')
    detect(when(signal > ${var.zookeeper-latency_threshold_critical}, lasting=%{if var.zookeeper-latency_lasting_duration_critical == null}None%{else}'${var.zookeeper-latency_lasting_duration_critical}'%{endif}, at_least=${var.zookeeper-latency_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.zookeeper-latency_threshold_major}, lasting=%{if var.zookeeper-latency_lasting_duration_major == null}None%{else}'${var.zookeeper-latency_lasting_duration_major}'%{endif}, at_least=${var.zookeeper-latency_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.zookeeper-latency_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.zookeeper-latency_disabled_critical, var.zookeeper-latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.zookeeper-latency_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.zookeeper-latency_runbook_url, var.runbook_url), "")
    tip                   = var.zookeeper-latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.zookeeper-latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.zookeeper-latency_disabled_major, var.zookeeper-latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.zookeeper-latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.zookeeper-latency_runbook_url, var.runbook_url), "")
    tip                   = var.zookeeper-latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.zookeeper-latency_max_delay
}

