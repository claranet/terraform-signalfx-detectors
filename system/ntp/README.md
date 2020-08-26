# SYSTEM NTP SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-system-ntp" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//system/ntp?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

```

## Purpose

Creates SignalFx detectors with the following checks:

- NTP offset
- NTP heartbeat

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| detectors\_disabled | Disable all detectors in this module | bool | `"false"` | no |
| environment | Infrastructure environment | string | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | list | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | list | `[]` | no |
| notifications | Notification recipients list for every detectors | list | n/a | yes |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | `bool` | n/a | yes |
| heartbeat\_notifications | Notification recipients list for every alerting rules of heartbeat detector | `list` | `[]` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector (i.e. "10m") | `string` | `"20m"` | no |
| ntp\_aggregation\_function | Aggregation function and group by for ntp detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| ntp\_disabled | Disable all alerting rules for ntp detector | bool | `"null"` | no |
| ntp\_disabled\_warning | Disable warning alerting rule for ntp detector | bool | `"null"` | no |
| ntp\_notifications | Notification recipients list for every alerting rules of ntp detector | list | `[]` | no |
| ntp\_notifications\_warning | Notification recipients list for warning alerting rule of ntp detector | list | `[]` | no |
| ntp\_threshold\_warning | Warning threshold for ntp detector | number | `"1500"` | no |
| ntp\_transformation\_function | Transformation function for ntp detector (i.e. \".mean(over='5m')\")) | string | `"min"` | no |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | list | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| ntp\_id | id for detector ntp |
| heartbeat\_id | id for detector heartbeat |

## Related documentation

[Official documentation ntp](https://docs.signalfx.com/en/latest/integrations/agent/monitors/ntp.html)
