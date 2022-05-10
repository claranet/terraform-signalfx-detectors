resource "signalfx_detector" "cpu" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticache memcached cpu")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache') and filter('CacheNodeId', '*') and filter('stat', 'mean')
    signal = data('CPUUtilization', filter=base_filtering and ${module.filtering.signalflow})${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_threshold_critical}, lasting=%{if var.cpu_lasting_duration_critical == null}None%{else}'${var.cpu_lasting_duration_critical}'%{endif}, at_least=${var.cpu_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_threshold_major}, lasting=%{if var.cpu_lasting_duration_major == null}None%{else}'${var.cpu_lasting_duration_major}'%{endif}, at_least=${var.cpu_at_least_percentage_major}) and (not when(signal > ${var.cpu_threshold_critical}, lasting=%{if var.cpu_lasting_duration_critical == null}None%{else}'${var.cpu_lasting_duration_critical}'%{endif}, at_least=${var.cpu_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_disabled_critical, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_max_delay
}

resource "signalfx_detector" "hit_ratio" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticache memcached hit ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ElastiCache') and filter('CacheNodeId', '*') and filter('stat', 'mean')
    hits = data('GetHits', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.hit_ratio_aggregation_function}${var.hit_ratio_transformation_function}
    misses = data('GetMisses', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.hit_ratio_aggregation_function}${var.hit_ratio_transformation_function}
    signal = (hits/(hits+misses)).scale(100).fill(value=0).publish('signal')
    detect(when(signal < ${var.hit_ratio_threshold_major}, lasting=%{if var.hit_ratio_lasting_duration_major == null}None%{else}'${var.hit_ratio_lasting_duration_major}'%{endif}, at_least=${var.hit_ratio_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal < ${var.hit_ratio_threshold_minor}, lasting=%{if var.hit_ratio_lasting_duration_minor == null}None%{else}'${var.hit_ratio_lasting_duration_minor}'%{endif}, at_least=${var.hit_ratio_at_least_percentage_minor}) and (not when(signal < ${var.hit_ratio_threshold_major}, lasting=%{if var.hit_ratio_lasting_duration_major == null}None%{else}'${var.hit_ratio_lasting_duration_major}'%{endif}, at_least=${var.hit_ratio_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too low < ${var.hit_ratio_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.hit_ratio_disabled_major, var.hit_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.hit_ratio_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.hit_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.hit_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.hit_ratio_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.hit_ratio_disabled_minor, var.hit_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.hit_ratio_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.hit_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.hit_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.hit_ratio_max_delay
}

