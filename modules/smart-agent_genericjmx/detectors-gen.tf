resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Genericjmx heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('jmx_memory.used', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "memory_heap" {
  name = format("%s %s", local.detector_name_prefix, "Genericjmx memory heap")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('plugin_instance', 'memory-heap')
    A = data('jmx_memory.used', filter=base_filtering and ${module.filtering.signalflow})${var.memory_heap_aggregation_function}${var.memory_heap_transformation_function}
    B = data('jmx_memory.max', filter=base_filtering and ${module.filtering.signalflow})${var.memory_heap_aggregation_function}${var.memory_heap_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.memory_heap_threshold_critical}, lasting=%{if var.memory_heap_lasting_duration_critical == null}None%{else}'${var.memory_heap_lasting_duration_critical}'%{endif}, at_least=${var.memory_heap_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_heap_threshold_major}, lasting=%{if var.memory_heap_lasting_duration_major == null}None%{else}'${var.memory_heap_lasting_duration_major}'%{endif}, at_least=${var.memory_heap_at_least_percentage_major}) and (not when(signal > ${var.memory_heap_threshold_critical}, lasting=%{if var.memory_heap_lasting_duration_critical == null}None%{else}'${var.memory_heap_lasting_duration_critical}'%{endif}, at_least=${var.memory_heap_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_heap_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_heap_disabled_critical, var.memory_heap_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_heap_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_heap_runbook_url, var.runbook_url), "")
    tip                   = var.memory_heap_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_heap_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_heap_disabled_major, var.memory_heap_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_heap_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_heap_runbook_url, var.runbook_url), "")
    tip                   = var.memory_heap_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_heap_max_delay
}

resource "signalfx_detector" "gc_old_gen" {
  name = format("%s %s", local.detector_name_prefix, "Genericjmx gc old gen")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = (filter('plugin_instance', 'memory_pool-G1 Old Gen') or filter('plugin_instance', 'memory_pool-Tenured Gen'))
    A = data('jmx_memory.used', filter=base_filtering and ${module.filtering.signalflow})${var.gc_old_gen_aggregation_function}${var.gc_old_gen_transformation_function}
    B = data('jmx_memory.max', filter=base_filtering and ${module.filtering.signalflow})${var.gc_old_gen_aggregation_function}${var.gc_old_gen_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.gc_old_gen_threshold_critical}, lasting=%{if var.gc_old_gen_lasting_duration_critical == null}None%{else}'${var.gc_old_gen_lasting_duration_critical}'%{endif}, at_least=${var.gc_old_gen_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.gc_old_gen_threshold_major}, lasting=%{if var.gc_old_gen_lasting_duration_major == null}None%{else}'${var.gc_old_gen_lasting_duration_major}'%{endif}, at_least=${var.gc_old_gen_at_least_percentage_major}) and (not when(signal > ${var.gc_old_gen_threshold_critical}, lasting=%{if var.gc_old_gen_lasting_duration_critical == null}None%{else}'${var.gc_old_gen_lasting_duration_critical}'%{endif}, at_least=${var.gc_old_gen_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.gc_old_gen_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.gc_old_gen_disabled_critical, var.gc_old_gen_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.gc_old_gen_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.gc_old_gen_runbook_url, var.runbook_url), "")
    tip                   = var.gc_old_gen_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.gc_old_gen_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.gc_old_gen_disabled_major, var.gc_old_gen_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.gc_old_gen_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.gc_old_gen_runbook_url, var.runbook_url), "")
    tip                   = var.gc_old_gen_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.gc_old_gen_max_delay
}

