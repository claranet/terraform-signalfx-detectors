resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud SQL heartbeat")

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('database/cpu/usage_time', filter=${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "cpu_utilization" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud SQL CPU utilization")

  program_text = <<-EOF
    signal = data('database/cpu/utilization', ${module.filter-tags.filter_custom})${var.cpu_utilization_aggregation_function}${var.cpu_utilization_transformation_function}.scale(100).publish('signal')
    detect(when(signal > ${var.cpu_utilization_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_utilization_threshold_major}) and when(signal <= ${var.cpu_utilization_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_utilization_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_utilization_disabled_critical, var.cpu_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_utilization_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.cpu_utilization_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_utilization_disabled_major, var.cpu_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_utilization_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "disk_utilization" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud SQL disk utilization")

  program_text = <<-EOF
    signal = data('database/disk/utilization', ${module.filter-tags.filter_custom})${var.disk_utilization_aggregation_function}${var.disk_utilization_transformation_function}.scale(100).publish('signal')
    detect(when(signal > ${var.disk_utilization_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.disk_utilization_threshold_major}) and when(signal <= ${var.disk_utilization_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.disk_utilization_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_utilization_disabled_critical, var.disk_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_utilization_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.disk_utilization_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_utilization_disabled_major, var.disk_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_utilization_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "disk_utilization_forecast" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud SQL disk space is running out")

  program_text = <<-EOF
    from signalfx.detectors.countdown import countdown
    signal = data('database/disk/utilization', filter=${module.filter-tags.filter_custom}).publish('signal')
    countdown.hours_left_stream_incr_detector(stream=signal, maximum_capacity=${var.disk_utilization_forecast_maximum_capacity}, lower_threshold=${var.disk_utilization_forecast_hours_till_full}, fire_lasting=lasting('${var.disk_utilization_forecast_fire_lasting_time}', ${var.disk_utilization_forecast_fire_lasting_time_percent}), clear_threshold=${var.disk_utilization_forecast_clear_hours_remaining}, clear_lasting=lasting('${var.disk_utilization_forecast_clear_lasting_time}', ${var.disk_utilization_forecast_clear_lasting_time_percent}), use_double_ewma=${var.disk_utilization_forecast_use_ewma}).publish('CRIT')
EOF

  rule {
    description           = "in ${var.disk_utilization_forecast_hours_till_full}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_utilization_forecast_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_utilization_forecast_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "memory_utilization" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud SQL memory utilization")

  program_text = <<-EOF
    signal = data('database/memory/utilization', ${module.filter-tags.filter_custom})${var.memory_utilization_aggregation_function}${var.memory_utilization_transformation_function}.scale(100).publish('signal')
    detect(when(signal > ${var.memory_utilization_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_utilization_threshold_major}) and when(signal <= ${var.memory_utilization_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_utilization_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_utilization_disabled_critical, var.memory_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_utilization_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.memory_utilization_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_utilization_disabled_major, var.memory_utilization_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_utilization_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "memory_utilization_forecast" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud SQL memory is running out")

  program_text = <<-EOF
    from signalfx.detectors.countdown import countdown
    signal = data('database/memory/utilization', filter=${module.filter-tags.filter_custom}).publish('signal')
    countdown.hours_left_stream_incr_detector(stream=signal, maximum_capacity=${var.memory_utilization_forecast_maximum_capacity}, lower_threshold=${var.memory_utilization_forecast_hours_till_full}, fire_lasting=lasting('${var.memory_utilization_forecast_fire_lasting_time}', ${var.memory_utilization_forecast_fire_lasting_time_percent}), clear_threshold=${var.memory_utilization_forecast_clear_hours_remaining}, clear_lasting=lasting('${var.memory_utilization_forecast_clear_lasting_time}', ${var.memory_utilization_forecast_clear_lasting_time_percent}), use_double_ewma=${var.memory_utilization_forecast_use_ewma}).publish('CRIT')
EOF

  rule {
    description           = "in ${var.memory_utilization_forecast_hours_till_full}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_utilization_forecast_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_utilization_forecast_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

