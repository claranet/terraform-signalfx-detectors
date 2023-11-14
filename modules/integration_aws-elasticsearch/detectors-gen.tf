resource "signalfx_detector" "jvm_memory_pressure" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch jvm memory pressure")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'upper') and filter('NodeId', '*')
    signal = data('JVMMemoryPressure', filter=base_filtering and ${module.filtering.signalflow})${var.jvm_memory_pressure_aggregation_function}${var.jvm_memory_pressure_transformation_function}.publish('signal')
    detect(when(signal > ${var.jvm_memory_pressure_threshold_critical}, lasting=%{if var.jvm_memory_pressure_lasting_duration_critical == null}None%{else}'${var.jvm_memory_pressure_lasting_duration_critical}'%{endif}, at_least=${var.jvm_memory_pressure_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.jvm_memory_pressure_threshold_major}, lasting=%{if var.jvm_memory_pressure_lasting_duration_major == null}None%{else}'${var.jvm_memory_pressure_lasting_duration_major}'%{endif}, at_least=${var.jvm_memory_pressure_at_least_percentage_major}) and (not when(signal > ${var.jvm_memory_pressure_threshold_critical}, lasting=%{if var.jvm_memory_pressure_lasting_duration_critical == null}None%{else}'${var.jvm_memory_pressure_lasting_duration_critical}'%{endif}, at_least=${var.jvm_memory_pressure_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_memory_pressure_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.jvm_memory_pressure_disabled_critical, var.jvm_memory_pressure_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_memory_pressure_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.jvm_memory_pressure_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_pressure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.jvm_memory_pressure_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_memory_pressure_disabled_major, var.jvm_memory_pressure_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_memory_pressure_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.jvm_memory_pressure_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_pressure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.jvm_memory_pressure_max_delay
}

resource "signalfx_detector" "fourxx_http_response" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch 4xx http response")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'sum')
    A = data('4xx', filter=base_filtering and ${module.filtering.signalflow})${var.fourxx_http_response_aggregation_function}${var.fourxx_http_response_transformation_function}
    B = data('2xx', filter=base_filtering and ${module.filtering.signalflow})${var.fourxx_http_response_aggregation_function}${var.fourxx_http_response_transformation_function}
    signal = (A/(A+B)*100).publish('signal')
    detect(when(signal > ${var.fourxx_http_response_threshold_critical}, lasting=%{if var.fourxx_http_response_lasting_duration_critical == null}None%{else}'${var.fourxx_http_response_lasting_duration_critical}'%{endif}, at_least=${var.fourxx_http_response_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.fourxx_http_response_threshold_major}, lasting=%{if var.fourxx_http_response_lasting_duration_major == null}None%{else}'${var.fourxx_http_response_lasting_duration_major}'%{endif}, at_least=${var.fourxx_http_response_at_least_percentage_major}) and (not when(signal > ${var.fourxx_http_response_threshold_critical}, lasting=%{if var.fourxx_http_response_lasting_duration_critical == null}None%{else}'${var.fourxx_http_response_lasting_duration_critical}'%{endif}, at_least=${var.fourxx_http_response_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.fourxx_http_response_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.fourxx_http_response_disabled_critical, var.fourxx_http_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fourxx_http_response_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.fourxx_http_response_runbook_url, var.runbook_url), "")
    tip                   = var.fourxx_http_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.fourxx_http_response_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.fourxx_http_response_disabled_major, var.fourxx_http_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fourxx_http_response_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.fourxx_http_response_runbook_url, var.runbook_url), "")
    tip                   = var.fourxx_http_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.fourxx_http_response_max_delay
}

resource "signalfx_detector" "fivexx_http_response" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch 5xx http response")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'sum')
    A = data('5xx', filter=base_filtering and ${module.filtering.signalflow})${var.fivexx_http_response_aggregation_function}${var.fivexx_http_response_transformation_function}
    B = data('2xx', filter=base_filtering and ${module.filtering.signalflow})${var.fivexx_http_response_aggregation_function}${var.fivexx_http_response_transformation_function}
    signal = (A/(A+B)*100).publish('signal')
    detect(when(signal > ${var.fivexx_http_response_threshold_critical}, lasting=%{if var.fivexx_http_response_lasting_duration_critical == null}None%{else}'${var.fivexx_http_response_lasting_duration_critical}'%{endif}, at_least=${var.fivexx_http_response_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.fivexx_http_response_threshold_major}, lasting=%{if var.fivexx_http_response_lasting_duration_major == null}None%{else}'${var.fivexx_http_response_lasting_duration_major}'%{endif}, at_least=${var.fivexx_http_response_at_least_percentage_major}) and (not when(signal > ${var.fivexx_http_response_threshold_critical}, lasting=%{if var.fivexx_http_response_lasting_duration_critical == null}None%{else}'${var.fivexx_http_response_lasting_duration_critical}'%{endif}, at_least=${var.fivexx_http_response_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.fivexx_http_response_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.fivexx_http_response_disabled_critical, var.fivexx_http_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fivexx_http_response_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.fivexx_http_response_runbook_url, var.runbook_url), "")
    tip                   = var.fivexx_http_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.fivexx_http_response_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.fivexx_http_response_disabled_major, var.fivexx_http_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fivexx_http_response_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.fivexx_http_response_runbook_url, var.runbook_url), "")
    tip                   = var.fivexx_http_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.fivexx_http_response_max_delay
}

resource "signalfx_detector" "shard_count" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch shard count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'upper') and filter('NodeId', '*')
    A = data('ShardCount', filter=base_filtering and ${module.filtering.signalflow})${var.shard_count_aggregation_function}${var.shard_count_transformation_function}
    signal = A.sum(by=['NodeId']).publish('signal')
    detect(when(signal > ${var.shard_count_threshold_critical}, lasting=%{if var.shard_count_lasting_duration_critical == null}None%{else}'${var.shard_count_lasting_duration_critical}'%{endif}, at_least=${var.shard_count_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.shard_count_threshold_major}, lasting=%{if var.shard_count_lasting_duration_major == null}None%{else}'${var.shard_count_lasting_duration_major}'%{endif}, at_least=${var.shard_count_at_least_percentage_major}) and (not when(signal > ${var.shard_count_threshold_critical}, lasting=%{if var.shard_count_lasting_duration_critical == null}None%{else}'${var.shard_count_lasting_duration_critical}'%{endif}, at_least=${var.shard_count_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.shard_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.shard_count_disabled_critical, var.shard_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.shard_count_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.shard_count_runbook_url, var.runbook_url), "")
    tip                   = var.shard_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.shard_count_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.shard_count_disabled_major, var.shard_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.shard_count_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.shard_count_runbook_url, var.runbook_url), "")
    tip                   = var.shard_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.shard_count_max_delay
}

