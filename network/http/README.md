# Network/Http SignalFx detectors

This module creates some detectors associated with "Check URL". For code match and regex match we assumed that we don't want the alert to be triggered immediately after an error because errors can occurs sometime without to be an incident.

So we introduced the lasting option to check if all datapoint on a period are in error and so to be sure it's an incident on the platform.

## How to use this module

```hcl
module "signalfx-detectors-http" {
  source        = "github.com/claranet/terraform-signalfx-detectors.git//network/http?ref={revision}"

  environment   = var.environment
  notifications = local.notifications

  filter_custom_includes = ["env:${var.environment}"]

  http_code_matched_lasting_duration = "5m"

}
```

## Purpose

* HTTP Heartbeat
* HTTP code matched
* HTTP regex matched
* HTTP response time
* HTTP content length
* TLS certificate expiring in xx days
* TLS certificate is invalid

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| certificate\_expiration\_date\_aggregation\_function | Aggregation function and group by for certificate\_expiration\_date detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| certificate\_expiration\_date\_disabled | Disable all alerting rules for certificate\_expiration\_date detector | `bool` | `null` | no |
| certificate\_expiration\_date\_disabled\_critical | Disable critical alerting rule for certificate\_expiration\_date detector | `bool` | `null` | no |
| certificate\_expiration\_date\_disabled\_major | Disable major alerting rule for certificate\_expiration\_date detector | `bool` | `null` | no |
| certificate\_expiration\_date\_notifications | Notification recipients list per severity overridden for certificate\_expiration\_date detector | `map(list(string))` | `{}` | no |
| certificate\_expiration\_date\_threshold\_critical | Critical threshold for certificate\_expiration\_date detector | `number` | `15` | no |
| certificate\_expiration\_date\_threshold\_major | Major threshold for certificate\_expiration\_date detector | `number` | `30` | no |
| certificate\_expiration\_date\_transformation\_function | Transformation function for certificate\_expiration\_date detector (i.e. ".mean(over='5m')") | `string` | `".max(over='5m')"` | no |
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| environment | Infrastructure environment | `string` | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | `list` | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | `list` | `[]` | no |
| heartbeat\_aggregation\_function | Aggregation function and group by for heartbeat detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | `bool` | `null` | no |
| heartbeat\_notifications | Notification recipients list per severity overridden for heartbeat detector | `map(list(string))` | `{}` | no |
| heartbeat\_timeframe | Timeframe for heartbeat detector (i.e. "10m") | `string` | `"20m"` | no |
| http\_code\_matched\_aggregation\_function | Aggregation function and group by for http\_code\_matched detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| http\_code\_matched\_at\_least\_percentage | Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0) | `number` | `0.9` | no |
| http\_code\_matched\_disabled | Disable all alerting rules for http\_code\_matched detector | `bool` | `null` | no |
| http\_code\_matched\_disabled\_critical | Disable critical alerting rule for http\_code\_matched detector | `bool` | `null` | no |
| http\_code\_matched\_lasting\_duration\_seconds | Duration that indicates how long we wait before triggering the http\_code\_matched alert. Specified as s, m, h, d | `string` | `"60"` | no |
| http\_code\_matched\_notifications | Notification recipients list per severity overridden for http\_code\_matched detector | `map(list(string))` | `{}` | no |
| http\_code\_matched\_transformation\_function | Transformation function for http\_code\_matched detector (i.e. ".mean(over='5m')") | `string` | `".max(over='1m')"` | no |
| http\_content\_length\_aggregation\_function | Aggregation function and group by for http\_content\_length detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| http\_content\_length\_disabled | Disable all alerting rules for http\_content\_length detector | `bool` | `null` | no |
| http\_content\_length\_notifications | Notification recipients list per severity overridden for http\_content\_length detector | `map(list(string))` | `{}` | no |
| http\_content\_length\_threshold\_major | Critical threshold for http\_content\_length detector | `number` | `10` | no |
| http\_content\_length\_transformation\_function | Transformation function for http\_content\_length detector (i.e. ".mean(over='5m')") | `string` | `".max(over='15m')"` | no |
| http\_regex\_matched\_aggregation\_function | Aggregation function and group by for http\_regex\_matched detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| http\_regex\_matched\_at\_least\_percentage | Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0) | `number` | `0.9` | no |
| http\_regex\_matched\_disabled | Disable all alerting rules for http\_regex\_matched detector | `bool` | `null` | no |
| http\_regex\_matched\_disabled\_critical | Disable critical alerting rule for http\_regex\_matched detector | `bool` | `null` | no |
| http\_regex\_matched\_lasting\_duration\_seconds | Duration that indicates how long we wait before triggering the http\_regex\_matched alert. Specified as s, m, h, d | `string` | `"60"` | no |
| http\_regex\_matched\_notifications | Notification recipients list per severity overridden for http\_regex\_matched detector | `map(list(string))` | `{}` | no |
| http\_regex\_matched\_transformation\_function | Transformation function for http\_regex\_matched detector (i.e. ".mean(over='5m')") | `string` | `".max(over='5m')"` | no |
| http\_response\_time\_aggregation\_function | Aggregation function and group by for http\_response\_time detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| http\_response\_time\_disabled | Disable all alerting rules for http\_response\_time detector | `bool` | `null` | no |
| http\_response\_time\_disabled\_critical | Disable critical alerting rule for http\_response\_time detector | `bool` | `null` | no |
| http\_response\_time\_disabled\_major | Disable major alerting rule for http\_response\_time detector | `bool` | `null` | no |
| http\_response\_time\_notifications | Notification recipients list per severity overridden for http\_response\_time detector | `map(list(string))` | `{}` | no |
| http\_response\_time\_threshold\_critical | Critical threshold for http\_response\_time detector | `number` | `2` | no |
| http\_response\_time\_threshold\_major | Major threshold for http\_response\_time detector | `number` | `1` | no |
| http\_response\_time\_transformation\_function | Transformation function for http\_response\_time detector (i.e. ".mean(over='5m')") | `string` | `".min(over='15m')"` | no |
| invalid\_tls\_certificate\_aggregation\_function | Aggregation function and group by for invalid\_tls\_certificate detector (i.e. ".mean(by=['host'])") | `string` | `""` | no |
| invalid\_tls\_certificate\_disabled | Disable all alerting rules for invalid\_tls\_certificate detector | `bool` | `null` | no |
| invalid\_tls\_certificate\_disabled\_critical | Disable critical alerting rule for invalid\_tls\_certificate detector | `bool` | `null` | no |
| invalid\_tls\_certificate\_notifications | Notification recipients list per severity overridden for invalid\_tls\_certificate detector | `map(list(string))` | `{}` | no |
| invalid\_tls\_certificate\_transformation\_function | Transformation function for invalid\_tls\_certificate detector (i.e. ".mean(over='5m')") | `string` | `".max(over='5m')"` | no |
| notifications | Default notification recipients list per severity | <pre>object({<br>    critical = list(string)<br>    major    = list(string)<br>    minor    = list(string)<br>    warning  = list(string)<br>    info     = list(string)<br>  })</pre> | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| certificate\_expiration\_date | Detector resource for certificate\_expiration\_date |
| heartbeat | Detector resource for heartbeat |
| http\_code\_matched | Detector resource for http\_code\_matched |
| http\_content\_length | Detector resource for http\_content\_length |
| http\_regex\_matched | Detector resource for http\_regex\_matched |
| http\_response\_time | Detector resource for http\_response\_time |
| invalid\_tls\_certificate | Detector resource for invalid\_tls\_certificate |