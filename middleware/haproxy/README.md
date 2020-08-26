# MIDDLEWARE HAPROXY SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-middleware-haproxy" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//middleware/haproxy?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}
```

In order to work properly, this module needs some [extraMetrics](https://docs.signalfx.com/en/latest/integrations/agent/monitors/haproxy.html#non-default-metrics-version-4-7-0), the agent needs a least the following configuration for the [haproxy](https://docs.signalfx.com/en/latest/integrations/agent/monitors/haproxy.html) monitor :

```
monitors:
  - type: haproxy
    extraMetrics:
      - haproxy_session_limit
      - haproxy_session_total
      - haproxy_status
      - haproxy_request_total
```

## Purpose

Creates SignalFx detectors with the following checks:

* Haproxy heartbeat
* Haproxy server status
* Haproxy backend status
* Haproxy session limit (on frontend, backend and server)
* Haproxy 4xx response rate (on frontend and backend with http mode)
* Haproxy 5xx response rate (on frontend and backend with http mode)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_status\_aggregation\_function | Aggregation function and group by for backend status detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| backend\_status\_disabled | Disable all alerting rules for backend status detector | `bool` | `null` | no |
| backend\_status\_disabled\_critical | Disable critical alerting rule for backend status detector | `bool` | `null` | no |
| backend\_status\_notifications | Notification recipients list for every alerting rules of backend status detector | `list` | `[]` | no |
| backend\_status\_notifications\_critical | Notification recipients list for critical alerting rule of backend status detector | `list` | `[]` | no |
| backend\_status\_transformation\_function | Transformation function for backend status detector (i.e. \".mean(over='5m')\")) | `string` | `"min"` | no |
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| environment | Infrastructure environment | `string` | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | `list` | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | `list` | `[]` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | `bool` | `null` | no |
| heartbeat\_notifications | Notification recipients list for every alerting rules of heartbeat detector | `list` | `[]` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector (i.e. "10m") | `string` | `"20m"` | no |
| http\_4xx\_response\_aggregation\_function | Aggregation function and group by for http\_4xx\_response detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| http\_4xx\_response\_disabled | Disable all alerting rules for http\_4xx\_response detector | `bool` | `null` | no |
| http\_4xx\_response\_disabled\_critical | Disable critical alerting rule for http\_4xx\_response detector | `bool` | `null` | no |
| http\_4xx\_response\_disabled\_warning | Disable warning alerting rule for http\_4xx\_response detector | `bool` | `null` | no |
| http\_4xx\_response\_notifications | Notification recipients list for every alerting rules of http\_4xx\_response detector | `list` | `[]` | no |
| http\_4xx\_response\_notifications\_critical | Notification recipients list for critical alerting rule of http\_4xx\_response detector | `list` | `[]` | no |
| http\_4xx\_response\_notifications\_warning | Notification recipients list for warning alerting rule of http\_4xx\_response detector | `list` | `[]` | no |
| http\_4xx\_response\_threshold\_critical | Critical threshold for http\_4xx\_response detector | `number` | `80` | no |
| http\_4xx\_response\_threshold\_warning | Critical threshold for http\_4xx\_response detector | `number` | `50` | no |
| http\_4xx\_response\_transformation\_function | Transformation function for http\_4xx\_response detector (i.e. \".mean(over='5m')\")) | `string` | `"min"` | no |
| http\_5xx\_response\_aggregation\_function | Aggregation function and group by for http\_5xx\_response detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| http\_5xx\_response\_disabled | Disable all alerting rules for http\_5xx\_response detector | `bool` | `null` | no |
| http\_5xx\_response\_disabled\_critical | Disable critical alerting rule for http\_5xx\_response detector | `bool` | `null` | no |
| http\_5xx\_response\_disabled\_warning | Disable warning alerting rule for http\_5xx\_response detector | `bool` | `null` | no |
| http\_5xx\_response\_notifications | Notification recipients list for every alerting rules of http\_5xx\_response detector | `list` | `[]` | no |
| http\_5xx\_response\_notifications\_critical | Notification recipients list for critical alerting rule of http\_5xx\_response detector | `list` | `[]` | no |
| http\_5xx\_response\_notifications\_warning | Notification recipients list for warning alerting rule of http\_5xx\_response detector | `list` | `[]` | no |
| http\_5xx\_response\_threshold\_critical | Critical threshold for http\_5xx\_response detector | `number` | `80` | no |
| http\_5xx\_response\_threshold\_warning | Critical threshold for http\_5xx\_response detector | `number` | `50` | no |
| http\_5xx\_response\_transformation\_function | Transformation function for http\_5xx\_response detector (i.e. \".mean(over='5m')\")) | `string` | `"min"` | no |
| notifications | Notification recipients list for every detectors | `list` | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |
| server\_status\_aggregation\_function | Aggregation function and group by for server status detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| server\_status\_disabled | Disable all alerting rules for server status detector | `bool` | `null` | no |
| server\_status\_disabled\_critical | Disable critical alerting rule for server status detector | `bool` | `null` | no |
| server\_status\_notifications | Notification recipients list for every alerting rules of server status detector | `list` | `[]` | no |
| server\_status\_notifications\_critical | Notification recipients list for critical alerting rule of server status detector | `list` | `[]` | no |
| server\_status\_transformation\_function | Transformation function for server status detector (i.e. \".mean(over='5m')\")) | `string` | `"min"` | no |
| session\_limit\_aggregation\_function | Aggregation function and group by for session limit detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| session\_limit\_disabled | Disable all alerting rules for session limit detector | `bool` | `null` | no |
| session\_limit\_disabled\_critical | Disable critical alerting rule for session limit detector | `bool` | `null` | no |
| session\_limit\_disabled\_warning | Disable warning alerting rule for session limit detector | `bool` | `null` | no |
| session\_limit\_notifications | Notification recipients list for every alerting rules of session limit detector | `list` | `[]` | no |
| session\_limit\_notifications\_critical | Notification recipients list for critical alerting rule of session limit detector | `list` | `[]` | no |
| session\_limit\_notifications\_warning | Notification recipients list for warning alerting rule of session limit detector | `list` | `[]` | no |
| session\_limit\_threshold\_critical | Critical threshold for session limit detector | `number` | `90` | no |
| session\_limit\_threshold\_warning | Critical threshold for session limit detector | `number` | `80` | no |
| session\_limit\_transformation\_function | Transformation function for session limit detector (i.e. \".mean(over='5m')\")) | `string` | `"min"` | no |

## Outputs

| Name | Description |
|------|-------------|
| backend\_status\_id | id for detector backend\_status |
| heartbeat\_id | id for detector heartbeat |
| http\_4xx\_response\_id | id for detector http\_4xx\_response |
| http\_5xx\_response\_id | id for detector http\_5xx\_response |
| server\_status\_id | id for detector server\_status |
| session\_limit\_id | id for detector session\_limit |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/agent/monitors/haproxy.html)
[Haproxy blog post on the stats page](https://www.haproxy.com/fr/blog/exploring-the-haproxy-stats-page/)
[Haproxy documentation](https://cbonte.github.io/haproxy-dconv/2.0/configuration.html)

## Notes

In order to work properly, this module needs some [extraMetrics](https://docs.signalfx.com/en/latest/integrations/agent/monitors/haproxy.html#non-default-metrics-version-4-7-0), the agent needs a least the following configuration for the [haproxy](https://docs.signalfx.com/en/latest/integrations/agent/monitors/haproxy.html) monitor :

```
monitors:
  - type: haproxy
    extraMetrics:
      - haproxy_session_limit
      - haproxy_session_total
      - haproxy_status
      - haproxy_request_total
```

