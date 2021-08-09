resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure firewall heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.Network/azureFirewalls') and filter('primary_aggregation_type', 'true')
    signal = data('FirewallHealth', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "snat_port_utilization" {
  name = format("%s %s", local.detector_name_prefix, "Azure firewall snat port utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/azureFirewalls') and filter('primary_aggregation_type', 'true')
    signal = data('SNATPortUtilization', filter=base_filtering and ${module.filtering.signalflow}, rollup='max')${var.snat_port_utilization_aggregation_function}${var.snat_port_utilization_transformation_function}.publish('signal')
    detect(when(signal > ${var.snat_port_utilization_threshold_critical}%{ if var.snat_port_utilization_lasting_duration_critical != "None" }, lasting='${var.snat_port_utilization_lasting_duration_critical}', at_least=${var.snat_port_utilization_at_least_percentage_critical}%{ endif })).publish('CRIT')
    detect(when(signal > ${var.snat_port_utilization_threshold_major}%{ if var.snat_port_utilization_lasting_duration_major != "None" }, lasting='${var.snat_port_utilization_lasting_duration_major}', at_least=${var.snat_port_utilization_at_least_percentage_major}%{ endif }) and not when(signal > ${var.snat_port_utilization_threshold_critical}%{ if var.snat_port_utilization_lasting_duration_critical != "None" }, lasting='${var.snat_port_utilization_lasting_duration_critical}', at_least=${var.snat_port_utilization_at_least_percentage_critical}%{ endif })).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.snat_port_utilization_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.snat_port_utilization_disabled_critical, var.snat_port_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.snat_port_utilization_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.snat_port_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.snat_port_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.snat_port_utilization_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.snat_port_utilization_disabled_major, var.snat_port_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.snat_port_utilization_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.snat_port_utilization_runbook_url, var.runbook_url), "")
    tip                   = var.snat_port_utilization_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "throughput" {
  name = format("%s %s", local.detector_name_prefix, "Azure firewall throughput")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/azureFirewalls') and filter('primary_aggregation_type', 'true')
    throughput = data('Throughput', filter=base_filtering and ${module.filtering.signalflow})${var.throughput_aggregation_function}${var.throughput_transformation_function}
    signal = throughput.scale(0.000000953674316).publish('signal')
    detect(when(signal >= ${var.throughput_threshold_critical}%{ if var.throughput_lasting_duration_critical != "None" }, lasting='${var.throughput_lasting_duration_critical}', at_least=${var.throughput_at_least_percentage_critical}%{ endif })).publish('CRIT')
    detect(when(signal >= ${var.throughput_threshold_major}%{ if var.throughput_lasting_duration_major != "None" }, lasting='${var.throughput_lasting_duration_major}', at_least=${var.throughput_at_least_percentage_major}%{ endif }) and not when(signal >= ${var.throughput_threshold_critical}%{ if var.throughput_lasting_duration_critical != "None" }, lasting='${var.throughput_lasting_duration_critical}', at_least=${var.throughput_at_least_percentage_critical}%{ endif })).publish('MAJOR')
    detect(when(signal >= ${var.throughput_threshold_minor}%{ if var.throughput_lasting_duration_minor != "None" }, lasting='${var.throughput_lasting_duration_minor}', at_least=${var.throughput_at_least_percentage_minor}%{ endif }) and not when(signal >= ${var.throughput_threshold_major}%{ if var.throughput_lasting_duration_major != "None" }, lasting='${var.throughput_lasting_duration_major}', at_least=${var.throughput_at_least_percentage_major}%{ endif })).publish('MINOR')
    detect(when(signal >= ${var.throughput_threshold_warning}%{ if var.throughput_lasting_duration_warning != "None" }, lasting='${var.throughput_lasting_duration_warning}', at_least=${var.throughput_at_least_percentage_warning}%{ endif }) and not when(signal >= ${var.throughput_threshold_warning}%{ if var.throughput_lasting_duration_warning != "None" }, lasting='${var.throughput_lasting_duration_warning}', at_least=${var.throughput_at_least_percentage_warning}%{ endif })).publish('WARN')
EOF

  rule {
    description           = "is too high >= ${var.throughput_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.throughput_disabled_critical, var.throughput_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throughput_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.throughput_runbook_url, var.runbook_url), "")
    tip                   = var.throughput_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.throughput_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throughput_disabled_major, var.throughput_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throughput_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.throughput_runbook_url, var.runbook_url), "")
    tip                   = var.throughput_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.throughput_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.throughput_disabled_minor, var.throughput_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throughput_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.throughput_runbook_url, var.runbook_url), "")
    tip                   = var.throughput_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high >= ${var.throughput_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.throughput_disabled_warning, var.throughput_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throughput_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.throughput_runbook_url, var.runbook_url), "")
    tip                   = var.throughput_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "health_state" {
  name = format("%s %s", local.detector_name_prefix, "Azure firewall health state")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/azureFirewalls') and filter('primary_aggregation_type', 'true')
    signal = data('FirewallHealth', filter=base_filtering and ${module.filtering.signalflow})${var.health_state_aggregation_function}${var.health_state_transformation_function}.publish('signal')
    detect(when(signal < ${var.health_state_threshold_critical}%{ if var.health_state_lasting_duration_critical != "None" }, lasting='${var.health_state_lasting_duration_critical}', at_least=${var.health_state_at_least_percentage_critical}%{ endif })).publish('CRIT')
    detect(when(signal < ${var.health_state_threshold_major}%{ if var.health_state_lasting_duration_major != "None" }, lasting='${var.health_state_lasting_duration_major}', at_least=${var.health_state_at_least_percentage_major}%{ endif }) and not when(signal < ${var.health_state_threshold_critical}%{ if var.health_state_lasting_duration_critical != "None" }, lasting='${var.health_state_lasting_duration_critical}', at_least=${var.health_state_at_least_percentage_critical}%{ endif })).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.health_state_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.health_state_disabled_critical, var.health_state_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.health_state_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.health_state_runbook_url, var.runbook_url), "")
    tip                   = var.health_state_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.health_state_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.health_state_disabled_major, var.health_state_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.health_state_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.health_state_runbook_url, var.runbook_url), "")
    tip                   = var.health_state_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

