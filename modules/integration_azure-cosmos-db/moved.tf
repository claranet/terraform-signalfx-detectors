moved {
  from = signalfx_detector.db_4xx_requests
  to   = signalfx_detector.database_4xx_request_rate
}

moved {
  from = signalfx_detector.db_5xx_requests
  to   = signalfx_detector.database_5xx_request_rate
}

moved {
  from = signalfx_detector.used_rus_capacity
  to   = signalfx_detector.request_units_consumption
}
