resource "signalfx_detector" "wsrep_ready" {
  name = format("%s %s", local.detector_name_prefix, "MySQL Galera node")

  program_text = <<-EOF
    signal = data('mysql_wsrep_ready', filter=${module.filter-tags.filter_custom})${var.wsrep_ready_aggregation_function}${var.wsrep_ready_transformation_function}.publish('signal')
    detect(when(signal < ${var.wsrep_ready_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not ready"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.wsrep_ready_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.wsrep_ready_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "wsrep_local_state" {
  name = format("%s %s", local.detector_name_prefix, "MySQL Galera node state")

  program_text = <<-EOF
    signal = data('mysql_wsrep_local_state', filter=${module.filter-tags.filter_custom})${var.wsrep_local_state_aggregation_function}${var.wsrep_local_state_transformation_function}.publish('signal')
    detect(when(signal != ${var.wsrep_local_state_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is not Synced"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.wsrep_local_state_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.wsrep_local_state_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "wsrep_flow_control_paused" {
  name = format("%s %s", local.detector_name_prefix, "MySQL Galera replication paused ratio")

  program_text = <<-EOF
    signal = data('mysql_wsrep_flow_control_paused', filter=${module.filter-tags.filter_custom})${var.wsrep_flow_control_paused_aggregation_function}${var.wsrep_flow_control_paused_transformation_function}.publish('signal')
    detect(when(signal > ${var.wsrep_flow_control_paused_threshold_critical})).publish('MAJOR')
    detect(when(signal > ${var.wsrep_flow_control_paused_threshold_major}) and when(signal < ${var.wsrep_flow_control_paused_threshold_critical})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.wsrep_flow_control_paused_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.wsrep_flow_control_paused_disabled_major, var.wsrep_flow_control_paused_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.wsrep_flow_control_paused_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.wsrep_flow_control_paused_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.wsrep_flow_control_paused_disabled_minor, var.wsrep_flow_control_paused_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.wsrep_flow_control_paused_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "wsrep_local_recv_queue_avg" {
  name = format("%s %s", local.detector_name_prefix, "MySQL Galera Recv queue length")

  program_text = <<-EOF
    signal = data('mysql_wsrep_local_recv_queue_avg', filter=${module.filter-tags.filter_custom})${var.wsrep_local_recv_queue_avg_aggregation_function}${var.wsrep_local_recv_queue_avg_transformation_function}.publish('signal')
    detect(when(signal > ${var.wsrep_local_recv_queue_avg_threshold_critical})).publish('MAJOR')
    detect(when(signal > ${var.wsrep_local_recv_queue_avg_threshold_major}) and when(signal < ${var.wsrep_local_recv_queue_avg_threshold_critical})).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.wsrep_local_recv_queue_avg_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.wsrep_local_recv_queue_avg_disabled_major, var.wsrep_local_recv_queue_avg_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.wsrep_local_recv_queue_avg_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.wsrep_local_recv_queue_avg_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.wsrep_local_recv_queue_avg_disabled_minor, var.wsrep_local_recv_queue_avg_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.wsrep_local_recv_queue_avg_notifications, "minor", []), var.notifications.minor)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
