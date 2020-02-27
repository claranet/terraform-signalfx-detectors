resource "signalfx_detector" "system_heartbeat" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] System Heartbeat Check"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('cpu.utilization', filter=(not filter('aws_state', '*terminated}', '*stopped}')) and (not filter('gcp_status', '*TERMINATED}', '*STOPPING}')) and (not filter('azure_power_state', 'stop*', 'deallocat*')))
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.system_heartbeat_timeframe}').publish('CRIT')
	EOF

	rule {
		description = "System has not reported in ${var.system_heartbeat_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.system_heartbeat_disabled_flag}"
	}
}

resource "signalfx_detector" "cpu" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] CPU usage"

	program_text = <<-EOF
		signal = data('cpu.utilization')${cpu_filter_aggregation}
		detect(when(signal > ${var.cpu_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "CPU utilization > ${var.cpu_threshold_critical}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.cpu_disabled_flag}"
	}
}

resource "signalfx_detector" "load" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] CPU load 5 ratio"

	program_text = <<-EOF
		signal = data('load.midterm')${load_filter_aggregation}.${var.load_time_aggregator}(over='${var.load_timeframe}')
		detect(when(signal > ${var.load_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "${var.load_time_aggregator} > ${var.load_threshold_critical} for last ${var.load_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.load_disabled_flag}"
	}
}

resource "signalfx_detector" "disk_space" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Disk space usage"

	program_text = <<-EOF
		signal = data('disk.utilization')${disk_space_filter_aggregation}.${var.disk_space_time_aggregator}(over='${var.disk_space_timeframe}')
		detect(when(signal > ${var.disk_space_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "${var.disk_space_time_aggregator} > ${var.disk_space_threshold_critical} for last ${var.disk_space_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.disk_space_disabled_flag}"
	}
}

resource "signalfx_detector" "memory" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Usable Memory"

	program_text = <<-EOF
		A = data('memory.utilization')${memory_filter_aggregation}
		signal = (100-A).${var.memory_time_aggregator}(over='${var.memory_timeframe}')
		detect(when(signal > ${var.memory_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "${var.memory_time_aggregator} > ${var.memory_threshold_critical} for last ${var.memory_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.memory_disabled_flag}"
	}
}
