resource "signalfx_detector" "used_space" {
  name = format("%s %s", local.detector_name_prefix, "AWS EFS used space")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Gigibyte"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/EFS')
    used_space = data('StorageBytes', filter=base_filtering and filter('StorageClass', 'Total') and filter('stat', 'mean') and ${module.filtering.signalflow})${var.used_space_aggregation_function}${var.used_space_transformation_function}
    signal = used_space.scale(1/1024**3).publish('signal')
    detect(when(signal > ${var.used_space_threshold_critical}, lasting=%{if var.used_space_lasting_duration_critical == null}None%{else}'${var.used_space_lasting_duration_critical}'%{endif}, at_least=${var.used_space_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.used_space_threshold_major}, lasting=%{if var.used_space_lasting_duration_major == null}None%{else}'${var.used_space_lasting_duration_major}'%{endif}, at_least=${var.used_space_at_least_percentage_major}) and (not when(signal > ${var.used_space_threshold_critical}, lasting=%{if var.used_space_lasting_duration_critical == null}None%{else}'${var.used_space_lasting_duration_critical}'%{endif}, at_least=${var.used_space_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.used_space_threshold_critical}Gigibyte"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.used_space_disabled_critical, var.used_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_space_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.used_space_runbook_url, var.runbook_url), "")
    tip                   = var.used_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.used_space_threshold_major}Gigibyte"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.used_space_disabled_major, var.used_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_space_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.used_space_runbook_url, var.runbook_url), "")
    tip                   = var.used_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "io_limit" {
  name = format("%s %s", local.detector_name_prefix, "AWS EFS percent of io limit")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/EFS')
    signal = data('PercentIOLimit', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.io_limit_aggregation_function}${var.io_limit_transformation_function}.publish('signal')
    detect(when(signal > ${var.io_limit_threshold_major}, lasting=%{if var.io_limit_lasting_duration_major == null}None%{else}'${var.io_limit_lasting_duration_major}'%{endif}, at_least=${var.io_limit_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.io_limit_threshold_minor}, lasting=%{if var.io_limit_lasting_duration_minor == null}None%{else}'${var.io_limit_lasting_duration_minor}'%{endif}, at_least=${var.io_limit_at_least_percentage_minor}) and (not when(signal > ${var.io_limit_threshold_major}, lasting=%{if var.io_limit_lasting_duration_major == null}None%{else}'${var.io_limit_lasting_duration_major}'%{endif}, at_least=${var.io_limit_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.io_limit_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.io_limit_disabled_major, var.io_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.io_limit_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.io_limit_runbook_url, var.runbook_url), "")
    tip                   = var.io_limit_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.io_limit_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.io_limit_disabled_minor, var.io_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.io_limit_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.io_limit_runbook_url, var.runbook_url), "")
    tip                   = var.io_limit_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "read_throughput" {
  name = format("%s %s", local.detector_name_prefix, "AWS EFS percent of read throughput")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/EFS')
    read = data('DataReadIOBytes', filter=base_filtering and filter('stat', 'sum') and ${module.filtering.signalflow})${var.read_throughput_aggregation_function}${var.read_throughput_transformation_function}
    total = data('TotalIOBytes', filter=base_filtering and filter('stat', 'sum') and ${module.filtering.signalflow})${var.read_throughput_aggregation_function}${var.read_throughput_transformation_function}
    signal = (read/total).scale(100).publish('signal')
    detect(when(signal > ${var.read_throughput_threshold_minor}, lasting=%{if var.read_throughput_lasting_duration_minor == null}None%{else}'${var.read_throughput_lasting_duration_minor}'%{endif}, at_least=${var.read_throughput_at_least_percentage_minor})).publish('MINOR')
    detect(when(signal > ${var.read_throughput_threshold_warning}, lasting=%{if var.read_throughput_lasting_duration_warning == null}None%{else}'${var.read_throughput_lasting_duration_warning}'%{endif}, at_least=${var.read_throughput_at_least_percentage_warning}) and (not when(signal > ${var.read_throughput_threshold_minor}, lasting=%{if var.read_throughput_lasting_duration_minor == null}None%{else}'${var.read_throughput_lasting_duration_minor}'%{endif}, at_least=${var.read_throughput_at_least_percentage_minor}))).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.read_throughput_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.read_throughput_disabled_minor, var.read_throughput_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.read_throughput_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.read_throughput_runbook_url, var.runbook_url), "")
    tip                   = var.read_throughput_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.read_throughput_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.read_throughput_disabled_warning, var.read_throughput_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.read_throughput_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.read_throughput_runbook_url, var.runbook_url), "")
    tip                   = var.read_throughput_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "write_throughput" {
  name = format("%s %s", local.detector_name_prefix, "AWS EFS percent of write throughput")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/EFS')
    write = data('DataWriteIOBytes', filter=base_filtering and filter('stat', 'sum') and ${module.filtering.signalflow})${var.write_throughput_aggregation_function}${var.write_throughput_transformation_function}
    total = data('TotalIOBytes', filter=base_filtering and filter('stat', 'sum') and ${module.filtering.signalflow})${var.write_throughput_aggregation_function}${var.write_throughput_transformation_function}
    signal = (write/total).scale(100).publish('signal')
    detect(when(signal > ${var.write_throughput_threshold_minor}, lasting=%{if var.write_throughput_lasting_duration_minor == null}None%{else}'${var.write_throughput_lasting_duration_minor}'%{endif}, at_least=${var.write_throughput_at_least_percentage_minor})).publish('MINOR')
    detect(when(signal > ${var.write_throughput_threshold_warning}, lasting=%{if var.write_throughput_lasting_duration_warning == null}None%{else}'${var.write_throughput_lasting_duration_warning}'%{endif}, at_least=${var.write_throughput_at_least_percentage_warning}) and (not when(signal > ${var.write_throughput_threshold_minor}, lasting=%{if var.write_throughput_lasting_duration_minor == null}None%{else}'${var.write_throughput_lasting_duration_minor}'%{endif}, at_least=${var.write_throughput_at_least_percentage_minor}))).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.write_throughput_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.write_throughput_disabled_minor, var.write_throughput_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.write_throughput_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.write_throughput_runbook_url, var.runbook_url), "")
    tip                   = var.write_throughput_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.write_throughput_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.write_throughput_disabled_warning, var.write_throughput_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.write_throughput_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.write_throughput_runbook_url, var.runbook_url), "")
    tip                   = var.write_throughput_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "percent_of_permitted_throughput" {
  name = format("%s %s", local.detector_name_prefix, "AWS EFS percent of permitted throughput")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/EFS')
    metered = data('MeteredIOBytes', filter=base_filtering and filter('stat', 'sum') and ${module.filtering.signalflow})${var.percent_of_permitted_throughput_aggregation_function}${var.percent_of_permitted_throughput_transformation_function}
    permitted = data('PermittedThroughput', filter=base_filtering and filter('stat', 'sum') and ${module.filtering.signalflow})${var.percent_of_permitted_throughput_aggregation_function}${var.percent_of_permitted_throughput_transformation_function}
    signal = (metered/permitted.scale(1024)).scale(100).publish('signal')
    detect(when(signal > ${var.percent_of_permitted_throughput_threshold_major}, lasting=%{if var.percent_of_permitted_throughput_lasting_duration_major == null}None%{else}'${var.percent_of_permitted_throughput_lasting_duration_major}'%{endif}, at_least=${var.percent_of_permitted_throughput_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.percent_of_permitted_throughput_threshold_minor}, lasting=%{if var.percent_of_permitted_throughput_lasting_duration_minor == null}None%{else}'${var.percent_of_permitted_throughput_lasting_duration_minor}'%{endif}, at_least=${var.percent_of_permitted_throughput_at_least_percentage_minor}) and (not when(signal > ${var.percent_of_permitted_throughput_threshold_major}, lasting=%{if var.percent_of_permitted_throughput_lasting_duration_major == null}None%{else}'${var.percent_of_permitted_throughput_lasting_duration_major}'%{endif}, at_least=${var.percent_of_permitted_throughput_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.percent_of_permitted_throughput_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.percent_of_permitted_throughput_disabled_major, var.percent_of_permitted_throughput_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.percent_of_permitted_throughput_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.percent_of_permitted_throughput_runbook_url, var.runbook_url), "")
    tip                   = var.percent_of_permitted_throughput_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.percent_of_permitted_throughput_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.percent_of_permitted_throughput_disabled_minor, var.percent_of_permitted_throughput_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.percent_of_permitted_throughput_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.percent_of_permitted_throughput_runbook_url, var.runbook_url), "")
    tip                   = var.percent_of_permitted_throughput_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "burst_credit_balance" {
  name = format("%s %s", local.detector_name_prefix, "AWS EFS burst credit balance")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "credits"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/EFS')
    signal = data('BurstCreditBalance', filter=base_filtering and filter('stat', 'lower') and ${module.filtering.signalflow})${var.burst_credit_balance_aggregation_function}${var.burst_credit_balance_transformation_function}.publish('signal')
    detect(when(signal < ${var.burst_credit_balance_threshold_major}, lasting=%{if var.burst_credit_balance_lasting_duration_major == null}None%{else}'${var.burst_credit_balance_lasting_duration_major}'%{endif}, at_least=${var.burst_credit_balance_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.burst_credit_balance_threshold_major}credits"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.burst_credit_balance_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.burst_credit_balance_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.burst_credit_balance_runbook_url, var.runbook_url), "")
    tip                   = var.burst_credit_balance_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

