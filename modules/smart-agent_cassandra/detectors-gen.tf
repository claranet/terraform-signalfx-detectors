resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('counter.cassandra.Storage.Load.Count', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "read_latency_99th_percentile" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra read latency 99th percentile")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    signal = data('gauge.cassandra.ClientRequest.Read.Latency.99thPercentile', filter=${module.filtering.signalflow})${var.read_latency_99th_percentile_aggregation_function}${var.read_latency_99th_percentile_transformation_function}.publish('signal')
    detect(when(signal > ${var.read_latency_99th_percentile_threshold_critical}, lasting=%{if var.read_latency_99th_percentile_lasting_duration_critical == null}None%{else}'${var.read_latency_99th_percentile_lasting_duration_critical}'%{endif}, at_least=${var.read_latency_99th_percentile_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.read_latency_99th_percentile_threshold_major}, lasting=%{if var.read_latency_99th_percentile_lasting_duration_major == null}None%{else}'${var.read_latency_99th_percentile_lasting_duration_major}'%{endif}, at_least=${var.read_latency_99th_percentile_at_least_percentage_major}) and (not when(signal > ${var.read_latency_99th_percentile_threshold_critical}, lasting=%{if var.read_latency_99th_percentile_lasting_duration_critical == null}None%{else}'${var.read_latency_99th_percentile_lasting_duration_critical}'%{endif}, at_least=${var.read_latency_99th_percentile_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.read_latency_99th_percentile_threshold_critical}Second"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.read_latency_99th_percentile_disabled_critical, var.read_latency_99th_percentile_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.read_latency_99th_percentile_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.read_latency_99th_percentile_runbook_url, var.runbook_url), "")
    tip                   = var.read_latency_99th_percentile_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.read_latency_99th_percentile_threshold_major}Second"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.read_latency_99th_percentile_disabled_major, var.read_latency_99th_percentile_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.read_latency_99th_percentile_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.read_latency_99th_percentile_runbook_url, var.runbook_url), "")
    tip                   = var.read_latency_99th_percentile_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.read_latency_99th_percentile_max_delay
}

resource "signalfx_detector" "write_latency_99th_percentile" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra write latency 99th percentile")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    signal = data('gauge.cassandra.ClientRequest.Write.Latency.99thPercentile', filter=${module.filtering.signalflow})${var.write_latency_99th_percentile_aggregation_function}${var.write_latency_99th_percentile_transformation_function}.publish('signal')
    detect(when(signal > ${var.write_latency_99th_percentile_threshold_critical}, lasting=%{if var.write_latency_99th_percentile_lasting_duration_critical == null}None%{else}'${var.write_latency_99th_percentile_lasting_duration_critical}'%{endif}, at_least=${var.write_latency_99th_percentile_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.write_latency_99th_percentile_threshold_major}, lasting=%{if var.write_latency_99th_percentile_lasting_duration_major == null}None%{else}'${var.write_latency_99th_percentile_lasting_duration_major}'%{endif}, at_least=${var.write_latency_99th_percentile_at_least_percentage_major}) and (not when(signal > ${var.write_latency_99th_percentile_threshold_critical}, lasting=%{if var.write_latency_99th_percentile_lasting_duration_critical == null}None%{else}'${var.write_latency_99th_percentile_lasting_duration_critical}'%{endif}, at_least=${var.write_latency_99th_percentile_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.write_latency_99th_percentile_threshold_critical}Second"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.write_latency_99th_percentile_disabled_critical, var.write_latency_99th_percentile_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.write_latency_99th_percentile_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.write_latency_99th_percentile_runbook_url, var.runbook_url), "")
    tip                   = var.write_latency_99th_percentile_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.write_latency_99th_percentile_threshold_major}Second"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.write_latency_99th_percentile_disabled_major, var.write_latency_99th_percentile_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.write_latency_99th_percentile_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.write_latency_99th_percentile_runbook_url, var.runbook_url), "")
    tip                   = var.write_latency_99th_percentile_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.write_latency_99th_percentile_max_delay
}

resource "signalfx_detector" "read_latency_real_time" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra read latency real time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    A = data('counter.cassandra.ClientRequest.Read.TotalLatency.Count', filter=${module.filtering.signalflow})${var.read_latency_real_time_aggregation_function}${var.read_latency_real_time_transformation_function}
    B = data('counter.cassandra.ClientRequest.Read.Latency.Count', filter=${module.filtering.signalflow})${var.read_latency_real_time_aggregation_function}${var.read_latency_real_time_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.read_latency_real_time_threshold_critical}, lasting=%{if var.read_latency_real_time_lasting_duration_critical == null}None%{else}'${var.read_latency_real_time_lasting_duration_critical}'%{endif}, at_least=${var.read_latency_real_time_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.read_latency_real_time_threshold_major}, lasting=%{if var.read_latency_real_time_lasting_duration_major == null}None%{else}'${var.read_latency_real_time_lasting_duration_major}'%{endif}, at_least=${var.read_latency_real_time_at_least_percentage_major}) and (not when(signal > ${var.read_latency_real_time_threshold_critical}, lasting=%{if var.read_latency_real_time_lasting_duration_critical == null}None%{else}'${var.read_latency_real_time_lasting_duration_critical}'%{endif}, at_least=${var.read_latency_real_time_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.read_latency_real_time_threshold_critical}Second"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.read_latency_real_time_disabled_critical, var.read_latency_real_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.read_latency_real_time_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.read_latency_real_time_runbook_url, var.runbook_url), "")
    tip                   = var.read_latency_real_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.read_latency_real_time_threshold_major}Second"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.read_latency_real_time_disabled_major, var.read_latency_real_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.read_latency_real_time_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.read_latency_real_time_runbook_url, var.runbook_url), "")
    tip                   = var.read_latency_real_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.read_latency_real_time_max_delay
}

resource "signalfx_detector" "write_latency_real_time" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra write latency real time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    A = data('counter.cassandra.ClientRequest.Write.TotalLatency.Count', filter=${module.filtering.signalflow})${var.write_latency_real_time_aggregation_function}${var.write_latency_real_time_transformation_function}
    B = data('counter.cassandra.ClientRequest.Write.Latency.Count', filter=${module.filtering.signalflow})${var.write_latency_real_time_aggregation_function}${var.write_latency_real_time_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.write_latency_real_time_threshold_critical}, lasting=%{if var.write_latency_real_time_lasting_duration_critical == null}None%{else}'${var.write_latency_real_time_lasting_duration_critical}'%{endif}, at_least=${var.write_latency_real_time_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.write_latency_real_time_threshold_major}, lasting=%{if var.write_latency_real_time_lasting_duration_major == null}None%{else}'${var.write_latency_real_time_lasting_duration_major}'%{endif}, at_least=${var.write_latency_real_time_at_least_percentage_major}) and (not when(signal > ${var.write_latency_real_time_threshold_critical}, lasting=%{if var.write_latency_real_time_lasting_duration_critical == null}None%{else}'${var.write_latency_real_time_lasting_duration_critical}'%{endif}, at_least=${var.write_latency_real_time_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.write_latency_real_time_threshold_critical}Second"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.write_latency_real_time_disabled_critical, var.write_latency_real_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.write_latency_real_time_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.write_latency_real_time_runbook_url, var.runbook_url), "")
    tip                   = var.write_latency_real_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.write_latency_real_time_threshold_major}Second"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.write_latency_real_time_disabled_major, var.write_latency_real_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.write_latency_real_time_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.write_latency_real_time_runbook_url, var.runbook_url), "")
    tip                   = var.write_latency_real_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.write_latency_real_time_max_delay
}

resource "signalfx_detector" "transactional_read_latency_99th_percentile" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra transactional read latency 99th percentile")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    signal = data('gauge.cassandra.ClientRequest.CASRead.Latency.99thPercentile', filter=${module.filtering.signalflow})${var.transactional_read_latency_99th_percentile_aggregation_function}${var.transactional_read_latency_99th_percentile_transformation_function}.publish('signal')
    detect(when(signal > ${var.transactional_read_latency_99th_percentile_threshold_critical}, lasting=%{if var.transactional_read_latency_99th_percentile_lasting_duration_critical == null}None%{else}'${var.transactional_read_latency_99th_percentile_lasting_duration_critical}'%{endif}, at_least=${var.transactional_read_latency_99th_percentile_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.transactional_read_latency_99th_percentile_threshold_major}, lasting=%{if var.transactional_read_latency_99th_percentile_lasting_duration_major == null}None%{else}'${var.transactional_read_latency_99th_percentile_lasting_duration_major}'%{endif}, at_least=${var.transactional_read_latency_99th_percentile_at_least_percentage_major}) and (not when(signal > ${var.transactional_read_latency_99th_percentile_threshold_critical}, lasting=%{if var.transactional_read_latency_99th_percentile_lasting_duration_critical == null}None%{else}'${var.transactional_read_latency_99th_percentile_lasting_duration_critical}'%{endif}, at_least=${var.transactional_read_latency_99th_percentile_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.transactional_read_latency_99th_percentile_threshold_critical}Second"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.transactional_read_latency_99th_percentile_disabled_critical, var.transactional_read_latency_99th_percentile_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.transactional_read_latency_99th_percentile_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.transactional_read_latency_99th_percentile_runbook_url, var.runbook_url), "")
    tip                   = var.transactional_read_latency_99th_percentile_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.transactional_read_latency_99th_percentile_threshold_major}Second"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.transactional_read_latency_99th_percentile_disabled_major, var.transactional_read_latency_99th_percentile_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.transactional_read_latency_99th_percentile_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.transactional_read_latency_99th_percentile_runbook_url, var.runbook_url), "")
    tip                   = var.transactional_read_latency_99th_percentile_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.transactional_read_latency_99th_percentile_max_delay
}

resource "signalfx_detector" "transactional_write_latency_99th_percentile" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra transactional write latency 99th percentile")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    signal = data('gauge.cassandra.ClientRequest.CASWrite.Latency.99thPercentile', filter=${module.filtering.signalflow})${var.transactional_write_latency_99th_percentile_aggregation_function}${var.transactional_write_latency_99th_percentile_transformation_function}.publish('signal')
    detect(when(signal > ${var.transactional_write_latency_99th_percentile_threshold_critical}, lasting=%{if var.transactional_write_latency_99th_percentile_lasting_duration_critical == null}None%{else}'${var.transactional_write_latency_99th_percentile_lasting_duration_critical}'%{endif}, at_least=${var.transactional_write_latency_99th_percentile_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.transactional_write_latency_99th_percentile_threshold_major}, lasting=%{if var.transactional_write_latency_99th_percentile_lasting_duration_major == null}None%{else}'${var.transactional_write_latency_99th_percentile_lasting_duration_major}'%{endif}, at_least=${var.transactional_write_latency_99th_percentile_at_least_percentage_major}) and (not when(signal > ${var.transactional_write_latency_99th_percentile_threshold_critical}, lasting=%{if var.transactional_write_latency_99th_percentile_lasting_duration_critical == null}None%{else}'${var.transactional_write_latency_99th_percentile_lasting_duration_critical}'%{endif}, at_least=${var.transactional_write_latency_99th_percentile_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.transactional_write_latency_99th_percentile_threshold_critical}Second"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.transactional_write_latency_99th_percentile_disabled_critical, var.transactional_write_latency_99th_percentile_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.transactional_write_latency_99th_percentile_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.transactional_write_latency_99th_percentile_runbook_url, var.runbook_url), "")
    tip                   = var.transactional_write_latency_99th_percentile_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.transactional_write_latency_99th_percentile_threshold_major}Second"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.transactional_write_latency_99th_percentile_disabled_major, var.transactional_write_latency_99th_percentile_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.transactional_write_latency_99th_percentile_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.transactional_write_latency_99th_percentile_runbook_url, var.runbook_url), "")
    tip                   = var.transactional_write_latency_99th_percentile_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.transactional_write_latency_99th_percentile_max_delay
}

resource "signalfx_detector" "transactional_read_latency_real_time" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra transactional read latency real time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    A = data('counter.cassandra.ClientRequest.CASRead.TotalLatency.Count', filter=${module.filtering.signalflow})${var.transactional_read_latency_real_time_aggregation_function}${var.transactional_read_latency_real_time_transformation_function}
    B = data('counter.cassandra.ClientRequest.CASRead.Latency.Count', filter=${module.filtering.signalflow})${var.transactional_read_latency_real_time_aggregation_function}${var.transactional_read_latency_real_time_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.transactional_read_latency_real_time_threshold_critical}, lasting=%{if var.transactional_read_latency_real_time_lasting_duration_critical == null}None%{else}'${var.transactional_read_latency_real_time_lasting_duration_critical}'%{endif}, at_least=${var.transactional_read_latency_real_time_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.transactional_read_latency_real_time_threshold_major}, lasting=%{if var.transactional_read_latency_real_time_lasting_duration_major == null}None%{else}'${var.transactional_read_latency_real_time_lasting_duration_major}'%{endif}, at_least=${var.transactional_read_latency_real_time_at_least_percentage_major}) and (not when(signal > ${var.transactional_read_latency_real_time_threshold_critical}, lasting=%{if var.transactional_read_latency_real_time_lasting_duration_critical == null}None%{else}'${var.transactional_read_latency_real_time_lasting_duration_critical}'%{endif}, at_least=${var.transactional_read_latency_real_time_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.transactional_read_latency_real_time_threshold_critical}Second"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.transactional_read_latency_real_time_disabled_critical, var.transactional_read_latency_real_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.transactional_read_latency_real_time_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.transactional_read_latency_real_time_runbook_url, var.runbook_url), "")
    tip                   = var.transactional_read_latency_real_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.transactional_read_latency_real_time_threshold_major}Second"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.transactional_read_latency_real_time_disabled_major, var.transactional_read_latency_real_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.transactional_read_latency_real_time_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.transactional_read_latency_real_time_runbook_url, var.runbook_url), "")
    tip                   = var.transactional_read_latency_real_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.transactional_read_latency_real_time_max_delay
}

resource "signalfx_detector" "transactional_write_latency_real_time" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra transactional write latency real time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    A = data('counter.cassandra.ClientRequest.CASWrite.TotalLatency.Count', filter=${module.filtering.signalflow})${var.transactional_write_latency_real_time_aggregation_function}${var.transactional_write_latency_real_time_transformation_function}
    B = data('counter.cassandra.ClientRequest.CASWrite.Latency.Count', filter=${module.filtering.signalflow})${var.transactional_write_latency_real_time_aggregation_function}${var.transactional_write_latency_real_time_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.transactional_write_latency_real_time_threshold_critical}, lasting=%{if var.transactional_write_latency_real_time_lasting_duration_critical == null}None%{else}'${var.transactional_write_latency_real_time_lasting_duration_critical}'%{endif}, at_least=${var.transactional_write_latency_real_time_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.transactional_write_latency_real_time_threshold_major}, lasting=%{if var.transactional_write_latency_real_time_lasting_duration_major == null}None%{else}'${var.transactional_write_latency_real_time_lasting_duration_major}'%{endif}, at_least=${var.transactional_write_latency_real_time_at_least_percentage_major}) and (not when(signal > ${var.transactional_write_latency_real_time_threshold_critical}, lasting=%{if var.transactional_write_latency_real_time_lasting_duration_critical == null}None%{else}'${var.transactional_write_latency_real_time_lasting_duration_critical}'%{endif}, at_least=${var.transactional_write_latency_real_time_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.transactional_write_latency_real_time_threshold_critical}Second"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.transactional_write_latency_real_time_disabled_critical, var.transactional_write_latency_real_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.transactional_write_latency_real_time_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.transactional_write_latency_real_time_runbook_url, var.runbook_url), "")
    tip                   = var.transactional_write_latency_real_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.transactional_write_latency_real_time_threshold_major}Second"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.transactional_write_latency_real_time_disabled_major, var.transactional_write_latency_real_time_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.transactional_write_latency_real_time_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.transactional_write_latency_real_time_runbook_url, var.runbook_url), "")
    tip                   = var.transactional_write_latency_real_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.transactional_write_latency_real_time_max_delay
}

resource "signalfx_detector" "storage_exceptions_count" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra storage exceptions count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('counter.cassandra.Storage.Exceptions.Count', filter=${module.filtering.signalflow})${var.storage_exceptions_count_aggregation_function}${var.storage_exceptions_count_transformation_function}.publish('signal')
    detect(when(signal > ${var.storage_exceptions_count_threshold_major}, lasting=%{if var.storage_exceptions_count_lasting_duration_major == null}None%{else}'${var.storage_exceptions_count_lasting_duration_major}'%{endif}, at_least=${var.storage_exceptions_count_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.storage_exceptions_count_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.storage_exceptions_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.storage_exceptions_count_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.storage_exceptions_count_runbook_url, var.runbook_url), "")
    tip                   = var.storage_exceptions_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.storage_exceptions_count_max_delay
}

