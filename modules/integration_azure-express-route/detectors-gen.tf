resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Express Route heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.Network/expressRouteCircuits') and filter('primary_aggregation_type', 'true')
    signal = data('BgpAvailability', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

  max_delay = var.heartbeat_max_delay
}

resource "signalfx_detector" "bgp_availability" {
  name = format("%s %s", local.detector_name_prefix, "Azure Express Route bgp availability")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/expressRouteCircuits') and filter('primary_aggregation_type', 'true')
    signal = data('BgpAvailability', filter=base_filtering and ${module.filtering.signalflow})${var.bgp_availability_aggregation_function}${var.bgp_availability_transformation_function}.publish('signal')
    detect(when(signal < ${var.bgp_availability_threshold_warning}, lasting=%{if var.bgp_availability_lasting_duration_warning == null}None%{else}'${var.bgp_availability_lasting_duration_warning}'%{endif}, at_least=${var.bgp_availability_at_least_percentage_warning})).publish('WARN')
    detect(when(signal < ${var.bgp_availability_threshold_major}, lasting=%{if var.bgp_availability_lasting_duration_major == null}None%{else}'${var.bgp_availability_lasting_duration_major}'%{endif}, at_least=${var.bgp_availability_at_least_percentage_major}) and (not when(signal < ${var.bgp_availability_threshold_warning}, lasting=%{if var.bgp_availability_lasting_duration_warning == null}None%{else}'${var.bgp_availability_lasting_duration_warning}'%{endif}, at_least=${var.bgp_availability_at_least_percentage_warning}))).publish('MAJOR')
    detect(when(signal < ${var.bgp_availability_threshold_critical}, lasting=%{if var.bgp_availability_lasting_duration_critical == null}None%{else}'${var.bgp_availability_lasting_duration_critical}'%{endif}, at_least=${var.bgp_availability_at_least_percentage_critical}) and (not when(signal < ${var.bgp_availability_threshold_major}, lasting=%{if var.bgp_availability_lasting_duration_major == null}None%{else}'${var.bgp_availability_lasting_duration_major}'%{endif}, at_least=${var.bgp_availability_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.bgp_availability_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.bgp_availability_disabled_warning, var.bgp_availability_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.bgp_availability_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.bgp_availability_runbook_url, var.runbook_url), "")
    tip                   = var.bgp_availability_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.bgp_availability_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.bgp_availability_disabled_major, var.bgp_availability_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.bgp_availability_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.bgp_availability_runbook_url, var.runbook_url), "")
    tip                   = var.bgp_availability_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.bgp_availability_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.bgp_availability_disabled_critical, var.bgp_availability_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.bgp_availability_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.bgp_availability_runbook_url, var.runbook_url), "")
    tip                   = var.bgp_availability_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.bgp_availability_max_delay
}

resource "signalfx_detector" "arp_availability" {
  name = format("%s %s", local.detector_name_prefix, "Azure Express Route arp availability")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Network/expressRouteCircuits') and filter('primary_aggregation_type', 'true')
    signal = data('ArpAvailability', filter=base_filtering and ${module.filtering.signalflow})${var.arp_availability_aggregation_function}${var.arp_availability_transformation_function}.publish('signal')
    detect(when(signal < ${var.arp_availability_threshold_warning}, lasting=%{if var.arp_availability_lasting_duration_warning == null}None%{else}'${var.arp_availability_lasting_duration_warning}'%{endif}, at_least=${var.arp_availability_at_least_percentage_warning})).publish('WARN')
    detect(when(signal < ${var.arp_availability_threshold_major}, lasting=%{if var.arp_availability_lasting_duration_major == null}None%{else}'${var.arp_availability_lasting_duration_major}'%{endif}, at_least=${var.arp_availability_at_least_percentage_major}) and (not when(signal < ${var.arp_availability_threshold_warning}, lasting=%{if var.arp_availability_lasting_duration_warning == null}None%{else}'${var.arp_availability_lasting_duration_warning}'%{endif}, at_least=${var.arp_availability_at_least_percentage_warning}))).publish('MAJOR')
    detect(when(signal < ${var.arp_availability_threshold_critical}, lasting=%{if var.arp_availability_lasting_duration_critical == null}None%{else}'${var.arp_availability_lasting_duration_critical}'%{endif}, at_least=${var.arp_availability_at_least_percentage_critical}) and (not when(signal < ${var.arp_availability_threshold_major}, lasting=%{if var.arp_availability_lasting_duration_major == null}None%{else}'${var.arp_availability_lasting_duration_major}'%{endif}, at_least=${var.arp_availability_at_least_percentage_major}))).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.arp_availability_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.arp_availability_disabled_warning, var.arp_availability_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.arp_availability_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.arp_availability_runbook_url, var.runbook_url), "")
    tip                   = var.arp_availability_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.arp_availability_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.arp_availability_disabled_major, var.arp_availability_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.arp_availability_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.arp_availability_runbook_url, var.runbook_url), "")
    tip                   = var.arp_availability_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.arp_availability_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.arp_availability_disabled_critical, var.arp_availability_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.arp_availability_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.arp_availability_runbook_url, var.runbook_url), "")
    tip                   = var.arp_availability_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.arp_availability_max_delay
}

