resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Couchdb heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('couchdb_uptime_seconds', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "couchdb_httpd_status_code_4xx" {
  name = format("%s %s", local.detector_name_prefix, "Couchdb couchdb_httpd_status_code_4xx")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('couchdb_httpd_status_codes', filter=(filter('code', '400', '401', '403', '404', '405', '406', '409', '412', '413', '414', '415', '416', '417')) and ${module.filtering.signalflow}, rollup='sum')${var.couchdb_httpd_status_code_4xx_aggregation_function}${var.couchdb_httpd_status_code_4xx_transformation_function}
    B = data('couchdb_httpd_status_codes', filter=${module.filtering.signalflow}, rollup='sum')${var.couchdb_httpd_status_code_4xx_aggregation_function}${var.couchdb_httpd_status_code_4xx_transformation_function}
    signal = ((A/B).scale(100)).publish('signal')
    detect(when(signal > ${var.couchdb_httpd_status_code_4xx_threshold_critical}, lasting=%{if var.couchdb_httpd_status_code_4xx_lasting_duration_critical == null}None%{else}'${var.couchdb_httpd_status_code_4xx_lasting_duration_critical}'%{endif}, at_least=${var.couchdb_httpd_status_code_4xx_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.couchdb_httpd_status_code_4xx_threshold_major}, lasting=%{if var.couchdb_httpd_status_code_4xx_lasting_duration_major == null}None%{else}'${var.couchdb_httpd_status_code_4xx_lasting_duration_major}'%{endif}, at_least=${var.couchdb_httpd_status_code_4xx_at_least_percentage_major}) and (not when(signal > ${var.couchdb_httpd_status_code_4xx_threshold_critical}, lasting=%{if var.couchdb_httpd_status_code_4xx_lasting_duration_critical == null}None%{else}'${var.couchdb_httpd_status_code_4xx_lasting_duration_critical}'%{endif}, at_least=${var.couchdb_httpd_status_code_4xx_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.couchdb_httpd_status_code_4xx_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.couchdb_httpd_status_code_4xx_disabled_critical, var.couchdb_httpd_status_code_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.couchdb_httpd_status_code_4xx_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.couchdb_httpd_status_code_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.couchdb_httpd_status_code_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.couchdb_httpd_status_code_4xx_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.couchdb_httpd_status_code_4xx_disabled_major, var.couchdb_httpd_status_code_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.couchdb_httpd_status_code_4xx_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.couchdb_httpd_status_code_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.couchdb_httpd_status_code_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.couchdb_httpd_status_code_4xx_max_delay
}

resource "signalfx_detector" "couchdb_auth_cache" {
  name = format("%s %s", local.detector_name_prefix, "Couchdb couchdb_auth_cache")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    misses_total = data('couchdb_auth_cache_misses_total', filter=${module.filtering.signalflow})${var.couchdb_auth_cache_aggregation_function}${var.couchdb_auth_cache_transformation_function}
    request_total = data('couchdb_auth_cache_requests_total', filter=${module.filtering.signalflow})${var.couchdb_auth_cache_aggregation_function}${var.couchdb_auth_cache_transformation_function}
    signal = ((misses_total/request_total).scale(100)).publish('signal')
    detect(when(signal > ${var.couchdb_auth_cache_threshold_critical}, lasting=%{if var.couchdb_auth_cache_lasting_duration_critical == null}None%{else}'${var.couchdb_auth_cache_lasting_duration_critical}'%{endif}, at_least=${var.couchdb_auth_cache_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.couchdb_auth_cache_threshold_major}, lasting=%{if var.couchdb_auth_cache_lasting_duration_major == null}None%{else}'${var.couchdb_auth_cache_lasting_duration_major}'%{endif}, at_least=${var.couchdb_auth_cache_at_least_percentage_major}) and (not when(signal > ${var.couchdb_auth_cache_threshold_critical}, lasting=%{if var.couchdb_auth_cache_lasting_duration_critical == null}None%{else}'${var.couchdb_auth_cache_lasting_duration_critical}'%{endif}, at_least=${var.couchdb_auth_cache_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.couchdb_auth_cache_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.couchdb_auth_cache_disabled_critical, var.couchdb_auth_cache_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.couchdb_auth_cache_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.couchdb_auth_cache_runbook_url, var.runbook_url), "")
    tip                   = var.couchdb_auth_cache_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.couchdb_auth_cache_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.couchdb_auth_cache_disabled_major, var.couchdb_auth_cache_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.couchdb_auth_cache_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.couchdb_auth_cache_runbook_url, var.runbook_url), "")
    tip                   = var.couchdb_auth_cache_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.couchdb_auth_cache_max_delay
}

resource "signalfx_detector" "couchdb_couch_replicator_jobs" {
  name = format("%s %s", local.detector_name_prefix, "Couchdb couchdb_couch_replicator_jobs")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    jobs_crashed = data('couchdb_couch_replicator_jobs_crashed', filter=${module.filtering.signalflow})${var.couchdb_couch_replicator_jobs_aggregation_function}${var.couchdb_couch_replicator_jobs_transformation_function}
    jobs_total = data('couchdb_couch_replicator_jobs_total', filter=${module.filtering.signalflow})${var.couchdb_couch_replicator_jobs_aggregation_function}${var.couchdb_couch_replicator_jobs_transformation_function}
    signal = ((jobs_crashed/jobs_total).scale(100)).publish('signal')
    detect(when(signal > ${var.couchdb_couch_replicator_jobs_threshold_critical}, lasting=%{if var.couchdb_couch_replicator_jobs_lasting_duration_critical == null}None%{else}'${var.couchdb_couch_replicator_jobs_lasting_duration_critical}'%{endif}, at_least=${var.couchdb_couch_replicator_jobs_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.couchdb_couch_replicator_jobs_threshold_major}, lasting=%{if var.couchdb_couch_replicator_jobs_lasting_duration_major == null}None%{else}'${var.couchdb_couch_replicator_jobs_lasting_duration_major}'%{endif}, at_least=${var.couchdb_couch_replicator_jobs_at_least_percentage_major}) and (not when(signal > ${var.couchdb_couch_replicator_jobs_threshold_critical}, lasting=%{if var.couchdb_couch_replicator_jobs_lasting_duration_critical == null}None%{else}'${var.couchdb_couch_replicator_jobs_lasting_duration_critical}'%{endif}, at_least=${var.couchdb_couch_replicator_jobs_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.couchdb_couch_replicator_jobs_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.couchdb_couch_replicator_jobs_disabled_critical, var.couchdb_couch_replicator_jobs_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.couchdb_couch_replicator_jobs_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.couchdb_couch_replicator_jobs_runbook_url, var.runbook_url), "")
    tip                   = var.couchdb_couch_replicator_jobs_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.couchdb_couch_replicator_jobs_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.couchdb_couch_replicator_jobs_disabled_major, var.couchdb_couch_replicator_jobs_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.couchdb_couch_replicator_jobs_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.couchdb_couch_replicator_jobs_runbook_url, var.runbook_url), "")
    tip                   = var.couchdb_couch_replicator_jobs_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.couchdb_couch_replicator_jobs_max_delay
}

resource "signalfx_detector" "couchdb_erlang_processes" {
  name = format("%s %s", local.detector_name_prefix, "Couchdb couchdb_erlang_processes")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    erlang_processes = data('couchdb_erlang_processes', filter=${module.filtering.signalflow})${var.couchdb_erlang_processes_aggregation_function}${var.couchdb_erlang_processes_transformation_function}
    erlang_process_limit = data('couchdb_erlang_process_limit', filter=${module.filtering.signalflow})${var.couchdb_erlang_processes_aggregation_function}${var.couchdb_erlang_processes_transformation_function}
    signal = ((erlang_processes/erlang_process_limit).scale(100)).publish('signal')
    detect(when(signal > ${var.couchdb_erlang_processes_threshold_critical}, lasting=%{if var.couchdb_erlang_processes_lasting_duration_critical == null}None%{else}'${var.couchdb_erlang_processes_lasting_duration_critical}'%{endif}, at_least=${var.couchdb_erlang_processes_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.couchdb_erlang_processes_threshold_major}, lasting=%{if var.couchdb_erlang_processes_lasting_duration_major == null}None%{else}'${var.couchdb_erlang_processes_lasting_duration_major}'%{endif}, at_least=${var.couchdb_erlang_processes_at_least_percentage_major}) and (not when(signal > ${var.couchdb_erlang_processes_threshold_critical}, lasting=%{if var.couchdb_erlang_processes_lasting_duration_critical == null}None%{else}'${var.couchdb_erlang_processes_lasting_duration_critical}'%{endif}, at_least=${var.couchdb_erlang_processes_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.couchdb_erlang_processes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.couchdb_erlang_processes_disabled_critical, var.couchdb_erlang_processes_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.couchdb_erlang_processes_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.couchdb_erlang_processes_runbook_url, var.runbook_url), "")
    tip                   = var.couchdb_erlang_processes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.couchdb_erlang_processes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.couchdb_erlang_processes_disabled_major, var.couchdb_erlang_processes_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.couchdb_erlang_processes_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.couchdb_erlang_processes_runbook_url, var.runbook_url), "")
    tip                   = var.couchdb_erlang_processes_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.couchdb_erlang_processes_max_delay
}

resource "signalfx_detector" "cluster_is_stable" {
  name = format("%s %s", local.detector_name_prefix, "Couchdb cluster_is_stable")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('couchdb_couch_replicator_cluster_is_stable', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.cluster_is_stable_aggregation_function}.publish('signal')
    detect(when(signal < ${var.cluster_is_stable_threshold_critical}, lasting=%{if var.cluster_is_stable_lasting_duration_critical == null}None%{else}'${var.cluster_is_stable_lasting_duration_critical}'%{endif}, at_least=${var.cluster_is_stable_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.cluster_is_stable_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_is_stable_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_is_stable_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cluster_is_stable_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_is_stable_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cluster_is_stable_max_delay
}

