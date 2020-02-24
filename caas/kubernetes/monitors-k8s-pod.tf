resource "signalfx_detector" "pod_phase_status" {
	name = "Kubernetes Pod phase status failed"

	program_text = <<-EOF
		signal = data('kube_pod_status_phase', filter=(not filter('phase', 'Pending')) and (not filter('phase', 'Running')) and (not filter('phase', 'Succeeded')) and (not filter('phase', 'Unknown'))).sum(by=['namespace']).max(over='5m')
		detect(when(signal > 0)).publish('CRIT')
	EOF

	rule {
		description = "Maximum > 0 for last 5m"
		severity = "Critical"
		detect_label = "CRIT"
	}

}

resource "signalfx_detector" "error" {
	name = "Kubernetes Pod waiting errors"

	program_text = <<-EOF
		signal = data('kube_pod_container_status_waiting', filter=(not filter('reason', 'ContainerCreating'))).sum(by=['namespace', 'pod', 'reason']).min(over='15m')
		detect(when(signal > 0.5)).publish('CRIT')
	EOF

	rule {
		description = "Minimum > 0.5 for last 15m"
		severity = "Critical"
		detect_label = "CRIT"
	}

}

resource "signalfx_detector" "terminated" {
	name = "Kubernetes Pod terminated abnormally"

	program_text = <<-EOF
		signal = data('kube_pod_container_status_terminated', filter=(not filter('reason', 'ContainerCreating'))).sum(by=['namespace', 'pod', 'reason']).sum(over='10m')
		detect(when(signal > 0.5)).publish('CRIT')
	EOF

	rule {
		description = "Sum > 0.5 for last 10m"
		severity = "Critical"
		detect_label = "CRIT"
	}

}
