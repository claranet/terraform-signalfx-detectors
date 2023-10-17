resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
    signal = data('usedmemory', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "evicted_keys" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis evicted keys")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
    signal = data('evictedkeys', filter=base_filtering and ${module.filtering.signalflow})${var.evicted_keys_aggregation_function}${var.evicted_keys_transformation_function}.publish('signal')
    detect(when(signal > ${var.evicted_keys_threshold_critical}, lasting=%{if var.evicted_keys_lasting_duration_critical == null}None%{else}'${var.evicted_keys_lasting_duration_critical}'%{endif}, at_least=${var.evicted_keys_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.evicted_keys_threshold_major}, lasting=%{if var.evicted_keys_lasting_duration_major == null}None%{else}'${var.evicted_keys_lasting_duration_major}'%{endif}, at_least=${var.evicted_keys_at_least_percentage_major}) and (not when(signal > ${var.evicted_keys_threshold_critical}, lasting=%{if var.evicted_keys_lasting_duration_critical == null}None%{else}'${var.evicted_keys_lasting_duration_critical}'%{endif}, at_least=${var.evicted_keys_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.evicted_keys_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.evicted_keys_disabled_critical, var.evicted_keys_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.evicted_keys_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.evicted_keys_runbook_url, var.runbook_url), "")
    tip                   = var.evicted_keys_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.evicted_keys_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.evicted_keys_disabled_major, var.evicted_keys_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.evicted_keys_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.evicted_keys_runbook_url, var.runbook_url), "")
    tip                   = var.evicted_keys_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.evicted_keys_max_delay
}

resource "signalfx_detector" "processor_time" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis processor time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
    signal = data('percentProcessorTime', filter=base_filtering and ${module.filtering.signalflow})${var.processor_time_aggregation_function}${var.processor_time_transformation_function}.publish('signal')
    detect(when(signal > ${var.processor_time_threshold_critical}, lasting=%{if var.processor_time_lasting_duration_critical == null}None%{else}'${var.processor_time_lasting_duration_critical}'%{endif}, at_least=${var.processor_time_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.processor_time_threshold_major}, lasting=%{if var.processor_time_lasting_duration_major == null}None%{else}'${var.processor_time_lasting_duration_major}'%{endif}, at_least=${var.processor_time_at_least_percentage_major}) and (not when(signal > ${var.processor_time_threshold_critical}, lasting=%{if var.processor_time_lasting_duration_critical == null}None%{else}'${var.processor_time_lasting_duration_critical}'%{endif}, at_least=${var.processor_time_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.processor_time_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.processor_time_disabled_critical, var.processor_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.processor_time_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.processor_time_runbook_url, var.runbook_url), "")
    tip                   = var.processor_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.processor_time_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.processor_time_disabled_major, var.processor_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.processor_time_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.processor_time_runbook_url, var.runbook_url), "")
    tip                   = var.processor_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.processor_time_max_delay
}

resource "signalfx_detector" "load" {
  name = format("%s %s", local.detector_name_prefix, "Azure Redis load")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Cache/Redis') and filter('primary_aggregation_type', 'true')
    signal = data('serverLoad', filter=base_filtering and ${module.filtering.signalflow})${var.load_aggregation_function}${var.load_transformation_function}.publish('signal')
    detect(when(signal > ${var.load_threshold_critical}, lasting=%{if var.load_lasting_duration_critical == null}None%{else}'${var.load_lasting_duration_critical}'%{endif}, at_least=${var.load_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.load_threshold_major}, lasting=%{if var.load_lasting_duration_major == null}None%{else}'${var.load_lasting_duration_major}'%{endif}, at_least=${var.load_at_least_percentage_major}) and (not when(signal > ${var.load_threshold_critical}, lasting=%{if var.load_lasting_duration_critical == null}None%{else}'${var.load_lasting_duration_critical}'%{endif}, at_least=${var.load_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.load_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.load_disabled_critical, var.load_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.load_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.load_runbook_url, var.runbook_url), "")
    tip                   = var.load_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.load_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.load_disabled_major, var.load_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.load_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.load_runbook_url, var.runbook_url), "")
    tip                   = var.load_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.load_max_delay
}

