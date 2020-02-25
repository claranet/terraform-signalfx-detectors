resource "signalfx_detector" "cpu" {
	name = "CPU usage"

	program_text = <<-EOF
		signal = data('cpu.utilization').mean(by=['host'])
		detect(when(signal > ${var.cpu_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "Average > ${var.cpu_threshold_critical}"
		severity = "Critical"
		detect_label = "CRIT"
	}
}

resource "signalfx_detector" "load" {
	name = "CPU load 5 ratio"

	program_text = <<-EOF
		signal = data('load.midterm').mean(by=['host']).min(over='30m')
		detect(when(signal > ${var.load_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "Min > ${var.load_threshold_critical} for last 30m"
		severity = "Critical"
		detect_label = "CRIT"
	}
}

resource "signalfx_detector" "disk_space" {
	name = "Disk space usage"

	program_text = <<-EOF
		signal = data('disk.utilization').mean(by=['host']).max(over='5m')
		detect(when(signal > ${var.disk_space_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "Max > ${var.disk_space_threshold_critical} for last 5m"
		severity = "Critical"
		detect_label = "CRIT"
	}
}

resource "signalfx_detector" "memory" {
	name = "Usable Memory"

	program_text = <<-EOF
		A = data('memory.utilization').mean(by=['host'])
		signal = (100-A).max(over='5m')
		detect(when(signal > ${var.memory_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "Max > ${var.memory_threshold_critical} for last 5m"
		severity = "Critical"
		detect_label = "CRIT"
	}
}
