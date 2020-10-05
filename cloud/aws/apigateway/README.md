## Notes

There are 2 different versions of AWS API Gateway service:

* the v1 known as "Rest API" and available through `apigateway` aws cli command
* the v2 known as "HTTP API" (or Websocket API) and available through `apigatewayv2` aws cli command

Sadly, for now, SignalFx syncs AWS API Gateway tags as dimensions only for v1 so if you use the new
version you could not rely on default tagging and filtering convention and you will probably need
to use default available tags from AWS like `aws_account_id`. Also, you will need to enable `is_v2`
flag to use right metrics (i.e. `5xx` instead of `5XXError`).
