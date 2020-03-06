output "heartbeat_id" {
	description 	= "id for detector heartbeat"
	value		= signalfx_detector.heartbeat.*.id
}

output "treatment_limit_id" {
	description 	= "id for detector treatment limit"
	value		= signalfx_detector.treatment_limit.*.id
}

