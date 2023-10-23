moved {
  from = signalfx_detector.http_4xx_errors_count
  to   = signalfx_detector.http_4xx_error_rate
}

moved {
  from = signalfx_detector.http_5xx_errors_count
  to   = signalfx_detector.http_5xx_error_rate
}
