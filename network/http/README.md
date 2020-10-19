# Network/Http SignalFx detectors

This module creates some detectors to check web urls and optionally their associated tls certificates.

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

## Notes

* By default, `signalfx-agent` collection interval is `10s`. Depending of webservices 
checked this could dangerous or useless to requet them as often so you can change 
`intervalSeconds` monitor(s) parameter as you prefer.

* The transformation allows to adapt sensitivity applying its function on a timeframe
which will change the evaluated value. The alert will be raised as soon the conditions are
met but comapared to a transformed value not true to reality and obviously more favorable.
This also affect the chart which could be not desired especially for troubleshooting
(webchecks often require accuracy). I.e. `max(over='15m')` on `http_code_matched` will
always be OK (`1`) on alert (and so chart also) even if more than `50%` of checks done
on the timeframe are failed.

* The `lasting` function does not change the value. It could apply on an evaluated value
different from the orginal (i.e. if you set `transformation_function` explicitely).
The chart will show the exact real value and even alert condition itself will be met
strictly immediately but alert will be raised only at the end of lasting timeframe
if the conditions have always remained.

* The `http.code_matched` and `http.regex.matched` based detectors are the most critical
They have only one severity (`Critical`) and use `lasting` function in addition to usual
transformation function (by default, not set only for them) which could affect 
their "sensitivity".

* By default, this module will raise alerts these detectors with moderate sensitivity in 
combination with `10s` collection interval and `lasting('60s')`: `6` datapoints for 1m
so the webcheck could fail 5 consecutive times before raising alert.

* Feel free to use variables to adapt this sensitivity depending of your needs to make 
detectors more tolerant (increasing lasting timeframe or even adding transformation) or
more strict (decreasing lasting timeframe or changing transformation function from `max`
to `min`).

* If you have multiple webhecks which require different sensitivity level so you can add
common dimension using `addExtraDimensions` to set of similar monitors on agent. Then,
you can import as many times this module with different value for `filter_custom_*` variables 
to match these different dimension(s) value(s).

* The certificate metrics will be collected only if `useHTTPS: true` (or if using the
deprecated `urls`) monitor option AND if the website supports and redirects `https`.

* The `http_content_length` based detector is disabled by default because not considered
as generic purpose but `disabled` variables allow to change this.

