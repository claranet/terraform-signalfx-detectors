resource "signalfx_detector" "messages_ready" {
  name = format("%s %s", local.detector_name_prefix, "AWS AmazonMQ RabbitMQ messages ready")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/AmazonMQ') and filter('stat', 'upper')
    signal = data('MessageReadyCount', filter=base_filtering and ${module.filtering.signalflow})${var.messages_ready_aggregation_function}${var.messages_ready_transformation_function}.publish('signal')
    detect(when(signal > ${var.messages_ready_threshold_critical}%{if var.messages_ready_lasting_duration_critical != null}, lasting='${var.messages_ready_lasting_duration_critical}', at_least=${var.messages_ready_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.messages_ready_threshold_major}%{if var.messages_ready_lasting_duration_major != null}, lasting='${var.messages_ready_lasting_duration_major}', at_least=${var.messages_ready_at_least_percentage_major}%{endif}) and (not when(signal > ${var.messages_ready_threshold_critical}%{if var.messages_ready_lasting_duration_critical != null}, lasting='${var.messages_ready_lasting_duration_critical}', at_least=${var.messages_ready_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.messages_ready_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_ready_disabled_critical, var.messages_ready_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.messages_ready_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.messages_ready_runbook_url, var.runbook_url), "")
    tip                   = var.messages_ready_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.messages_ready_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.messages_ready_disabled_major, var.messages_ready_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.messages_ready_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.messages_ready_runbook_url, var.runbook_url), "")
    tip                   = var.messages_ready_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.messages_ready_max_delay
}

resource "signalfx_detector" "messages_unacknowledged" {
  name = format("%s %s", local.detector_name_prefix, "AWS AmazonMQ RabbitMQ messages unacknowledged")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/AmazonMQ') and filter('stat', 'upper')
    signal = data('MessageUnacknowledgedCount', filter=base_filtering and ${module.filtering.signalflow})${var.messages_unacknowledged_aggregation_function}${var.messages_unacknowledged_transformation_function}.publish('signal')
    detect(when(signal > ${var.messages_unacknowledged_threshold_critical}%{if var.messages_unacknowledged_lasting_duration_critical != null}, lasting='${var.messages_unacknowledged_lasting_duration_critical}', at_least=${var.messages_unacknowledged_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.messages_unacknowledged_threshold_major}%{if var.messages_unacknowledged_lasting_duration_major != null}, lasting='${var.messages_unacknowledged_lasting_duration_major}', at_least=${var.messages_unacknowledged_at_least_percentage_major}%{endif}) and (not when(signal > ${var.messages_unacknowledged_threshold_critical}%{if var.messages_unacknowledged_lasting_duration_critical != null}, lasting='${var.messages_unacknowledged_lasting_duration_critical}', at_least=${var.messages_unacknowledged_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.messages_unacknowledged_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_unacknowledged_disabled_critical, var.messages_unacknowledged_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.messages_unacknowledged_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.messages_unacknowledged_runbook_url, var.runbook_url), "")
    tip                   = var.messages_unacknowledged_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.messages_unacknowledged_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.messages_unacknowledged_disabled_major, var.messages_unacknowledged_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.messages_unacknowledged_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.messages_unacknowledged_runbook_url, var.runbook_url), "")
    tip                   = var.messages_unacknowledged_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.messages_unacknowledged_max_delay
}

resource "signalfx_detector" "messages_ack_rate" {
  name = format("%s %s", local.detector_name_prefix, "AWS AmazonMQ RabbitMQ messages ack rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/AmazonMQ') and filter('stat', 'upper')
    msg = data('MessageCount', filter=base_filtering and ${module.filtering.signalflow})${var.messages_ack_rate_aggregation_function}${var.messages_ack_rate_transformation_function}
    signal = data('AckRate', filter=base_filtering and ${module.filtering.signalflow})${var.messages_ack_rate_aggregation_function}${var.messages_ack_rate_transformation_function}.publish('signal')
    detect(when(signal <= ${var.messages_ack_rate_threshold_critical}%{if var.messages_ack_rate_lasting_duration_critical != null}, lasting='${var.messages_ack_rate_lasting_duration_critical}', at_least=${var.messages_ack_rate_at_least_percentage_critical}%{endif}) and when(signal >= 0) and when(msg > 0)).publish('CRIT')
    detect(when(signal <= ${var.messages_ack_rate_threshold_major}%{if var.messages_ack_rate_lasting_duration_major != null}, lasting='${var.messages_ack_rate_lasting_duration_major}', at_least=${var.messages_ack_rate_at_least_percentage_major}%{endif}) and when(signal >= 0) and when(msg > 0) and (not when(signal <= ${var.messages_ack_rate_threshold_critical}%{if var.messages_ack_rate_lasting_duration_critical != null}, lasting='${var.messages_ack_rate_lasting_duration_critical}', at_least=${var.messages_ack_rate_at_least_percentage_critical}%{endif}) and when(signal >= 0) and when(msg > 0))).publish('MAJOR')
EOF

  rule {
    description           = "is to low and there are ready or unack messages <= ${var.messages_ack_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.messages_ack_rate_disabled_critical, var.messages_ack_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.messages_ack_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.messages_ack_rate_runbook_url, var.runbook_url), "")
    tip                   = var.messages_ack_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is to low and there are ready or unack messages <= ${var.messages_ack_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.messages_ack_rate_disabled_major, var.messages_ack_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.messages_ack_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.messages_ack_rate_runbook_url, var.runbook_url), "")
    tip                   = var.messages_ack_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.messages_ack_rate_max_delay
}

resource "signalfx_detector" "memory_used" {
  name = format("%s %s", local.detector_name_prefix, "AWS AmazonMQ RabbitMQ memory used")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/AmazonMQ') and filter('stat', 'upper')
    A = data('RabbitMQMemUsed', filter=base_filtering and ${module.filtering.signalflow})${var.memory_used_aggregation_function}${var.memory_used_transformation_function}
    B = data('RabbitMQMemLimit', filter=base_filtering and ${module.filtering.signalflow})${var.memory_used_aggregation_function}${var.memory_used_transformation_function}
    signal = ((A / B).scale(100)).publish('signal')
    detect(when(signal > ${var.memory_used_threshold_critical}%{if var.memory_used_lasting_duration_critical != null}, lasting='${var.memory_used_lasting_duration_critical}', at_least=${var.memory_used_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.memory_used_threshold_major}%{if var.memory_used_lasting_duration_major != null}, lasting='${var.memory_used_lasting_duration_major}', at_least=${var.memory_used_at_least_percentage_major}%{endif}) and (not when(signal > ${var.memory_used_threshold_critical}%{if var.memory_used_lasting_duration_critical != null}, lasting='${var.memory_used_lasting_duration_critical}', at_least=${var.memory_used_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_used_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_used_disabled_critical, var.memory_used_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_used_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_used_runbook_url, var.runbook_url), "")
    tip                   = var.memory_used_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_used_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_used_disabled_major, var.memory_used_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_used_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_used_runbook_url, var.runbook_url), "")
    tip                   = var.memory_used_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_used_max_delay
}

resource "signalfx_detector" "disk_free" {
  name = format("%s %s", local.detector_name_prefix, "AWS AmazonMQ RabbitMQ disk free")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "GiB"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/AmazonMQ') and filter('stat', 'upper')
    A = data('RabbitMQDiskFree', filter=base_filtering and ${module.filtering.signalflow})${var.disk_free_aggregation_function}${var.disk_free_transformation_function}
    B = data('RabbitMQDiskFreeLimit', filter=base_filtering and ${module.filtering.signalflow})${var.disk_free_aggregation_function}${var.disk_free_transformation_function}
    signal = ((A - B)/1024**3).publish('signal')
    detect(when(signal < ${var.disk_free_threshold_critical}%{if var.disk_free_lasting_duration_critical != null}, lasting='${var.disk_free_lasting_duration_critical}', at_least=${var.disk_free_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal < ${var.disk_free_threshold_major}%{if var.disk_free_lasting_duration_major != null}, lasting='${var.disk_free_lasting_duration_major}', at_least=${var.disk_free_at_least_percentage_major}%{endif}) and (not when(signal < ${var.disk_free_threshold_critical}%{if var.disk_free_lasting_duration_critical != null}, lasting='${var.disk_free_lasting_duration_critical}', at_least=${var.disk_free_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.disk_free_threshold_critical}GiB"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_free_disabled_critical, var.disk_free_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_free_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.disk_free_runbook_url, var.runbook_url), "")
    tip                   = var.disk_free_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.disk_free_threshold_major}GiB"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_free_disabled_major, var.disk_free_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.disk_free_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.disk_free_runbook_url, var.runbook_url), "")
    tip                   = var.disk_free_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.disk_free_max_delay
}

