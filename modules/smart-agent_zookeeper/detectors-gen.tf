resource "signalfx_detector" "health" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper health")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.zk_service_health', filter=${module.filtering.signalflow})${var.health_aggregation_function}${var.health_transformation_function}.publish('signal')
    detect(when(signal != ${var.health_threshold_critical}, lasting=%{if var.health_lasting_duration_critical == null}None%{else}'${var.health_lasting_duration_critical}'%{endif}, at_least=${var.health_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not running != ${var.health_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.health_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.health_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.health_runbook_url, var.runbook_url), "")
    tip                   = var.health_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.health_max_delay
}

resource "signalfx_detector" "cluster-latency" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper cluster-latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.zk_avg_latency', filter=${module.filtering.signalflow})${var.cluster-latency_aggregation_function}${var.cluster-latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster-latency_threshold_critical}, lasting=%{if var.cluster-latency_lasting_duration_critical == null}None%{else}'${var.cluster-latency_lasting_duration_critical}'%{endif}, at_least=${var.cluster-latency_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "Zookeeper global latency is too high > ${var.cluster-latency_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster-latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster-latency_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cluster-latency_runbook_url, var.runbook_url), "")
    tip                   = var.cluster-latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cluster-latency_max_delay
}

resource "signalfx_detector" "server-latency" {
  name = format("%s %s", local.detector_name_prefix, "Zookeeper server-latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.zk_avg_latency', filter=${module.filtering.signalflow})${var.server-latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.server-latency_threshold_major}, lasting=%{if var.server-latency_lasting_duration_major == null}None%{else}'${var.server-latency_lasting_duration_major}'%{endif}, at_least=${var.server-latency_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "Zookeeper server latency is too high > ${var.server-latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.server-latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.server-latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.server-latency_runbook_url, var.runbook_url), "")
    tip                   = var.server-latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.server-latency_max_delay
}

