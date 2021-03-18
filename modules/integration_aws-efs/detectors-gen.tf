resource "signalfx_detector" "used_space" {
  name = format("%s %s", local.detector_name_prefix, "AWS EFS used space")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  viz_options {
    label        = "signal"
    value_suffix = "GB"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/EFS')
    used_space = data('StorageBytes', filter=base_filtering and filter('StorageClass', 'Total') and filter('stat', 'mean') and ${module.filter-tags.filter_custom})${var.used_space_aggregation_function}${var.used_space_transformation_function}
    signal = used_space.scale(0.000000000931323).publish('signal')
    detect(when(signal > ${var.used_space_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.used_space_threshold_major}) and when(signal <= ${var.used_space_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.used_space_threshold_critical}GB"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.used_space_disabled_critical, var.used_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_space_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.used_space_runbook_url, var.runbook_url), "")
    tip                   = var.used_space_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.used_space_threshold_major}GB"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.used_space_disabled_major, var.used_space_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.used_space_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.used_space_runbook_url, var.runbook_url), "")
    tip                   = var.used_space_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "percent_io_limit" {
  name = format("%s %s", local.detector_name_prefix, "AWS EFS percent io limit")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/EFS')
    percent_io_limit = data('PercentIOLimit', filter=base_filtering and filter('stat', 'mean') and ${module.filter-tags.filter_custom})${var.percent_io_limit_aggregation_function}${var.percent_io_limit_transformation_function}
    signal = percent_io_limit.publish('signal')
    detect(when(signal > ${var.percent_io_limit_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.percent_io_limit_threshold_major}) and when(signal <= ${var.percent_io_limit_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.percent_io_limit_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.percent_io_limit_disabled_critical, var.percent_io_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.percent_io_limit_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.percent_io_limit_runbook_url, var.runbook_url), "")
    tip                   = var.percent_io_limit_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.percent_io_limit_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.percent_io_limit_disabled_major, var.percent_io_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.percent_io_limit_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.percent_io_limit_runbook_url, var.runbook_url), "")
    tip                   = var.percent_io_limit_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "iops_read_stats" {
  name = format("%s %s", local.detector_name_prefix, "AWS EFS iops read stats")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  viz_options {
    label        = "signal"
    value_suffix = "IOPs"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/EFS')
    data_read_io_bytes = data('DataReadIOBytes', filter=base_filtering and filter('stat', 'mean') and ${module.filter-tags.filter_custom})${var.iops_read_stats_aggregation_function}${var.iops_read_stats_transformation_function}
    meta_data_io_bytes = data('MetadataIOBytes', filter=base_filtering and filter('stat', 'mean') and ${module.filter-tags.filter_custom})${var.iops_read_stats_aggregation_function}${var.iops_read_stats_transformation_function}
    signal = (meta_data_io_bytes/data_read_io_bytes).scale(100).publish('signal')
    detect(when(signal > ${var.iops_read_stats_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.iops_read_stats_threshold_major}) and when(signal <= ${var.iops_read_stats_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.iops_read_stats_threshold_critical}IOPs"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.iops_read_stats_disabled_critical, var.iops_read_stats_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.iops_read_stats_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.iops_read_stats_runbook_url, var.runbook_url), "")
    tip                   = var.iops_read_stats_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.iops_read_stats_threshold_major}IOPs"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.iops_read_stats_disabled_major, var.iops_read_stats_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.iops_read_stats_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.iops_read_stats_runbook_url, var.runbook_url), "")
    tip                   = var.iops_read_stats_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "iops_write_stats" {
  name = format("%s %s", local.detector_name_prefix, "AWS EFS iops write stats")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  viz_options {
    label        = "signal"
    value_suffix = "IOPs"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/EFS')
    data_write_io_bytes = data('DataWriteIOBytes', filter=base_filtering and filter('stat', 'mean') and ${module.filter-tags.filter_custom})${var.iops_write_stats_aggregation_function}${var.iops_write_stats_transformation_function}
    meta_data_io_bytes = data('MetadataIOBytes', filter=base_filtering and filter('stat', 'mean') and ${module.filter-tags.filter_custom})${var.iops_write_stats_aggregation_function}${var.iops_write_stats_transformation_function}
    signal = (meta_data_io_bytes/data_write_io_bytes).scale(100).publish('signal')
    detect(when(signal > ${var.iops_write_stats_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.iops_write_stats_threshold_major}) and when(signal <= ${var.iops_write_stats_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.iops_write_stats_threshold_critical}IOPs"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.iops_write_stats_disabled_critical, var.iops_write_stats_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.iops_write_stats_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.iops_write_stats_runbook_url, var.runbook_url), "")
    tip                   = var.iops_write_stats_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.iops_write_stats_threshold_major}IOPs"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.iops_write_stats_disabled_major, var.iops_write_stats_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.iops_write_stats_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.iops_write_stats_runbook_url, var.runbook_url), "")
    tip                   = var.iops_write_stats_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

