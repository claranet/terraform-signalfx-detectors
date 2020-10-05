# SYSTEM Nagios status check SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-nagios-status-check" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//system/nagios-status-check?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

```

## Purpose

Creates SignalFx detectors with the following checks:

- Nagios check status

This module has been designed to alert with the same behavior as [Nagios](https://nagios-plugins.org/doc/guidelines.html#AEN78), basically a gauge equal to 1, 2 and 3 respectively triggering `WARNING`, `CRITICAL` and `UNKNOWN` alert. 

While SignalFx does not provide `Unknown` severity this module uses the `Major` severity for unknown alerts.

On the agent side, you need to send your metrics with the [telegraf exec plugin][https://docs.signalfx.com/en/latest/integrations/agent/monitors/telegraf-exec.html] which includes a [parser for nagios](https://github.com/influxdata/telegraf/blob/master/plugins/parsers/nagios/parser.go). The metric is named `nagios_state.state`, you need to add an `extraDimensions` to your monitor in order to be able to differantiate multiple script states.

Here is an example : 

```yaml
- type: telegraf/exec
  intervalSeconds: 180
  command: /usr/local/bin/scripts/check-ipmitool.pl
  extraDimensions:
    script: check_ipmitool
  telegrafParser:
    dataFormat: nagios
- type: telegraf/exec
  intervalSeconds: 900  
  command: /usr/local/bin/scripts/check-megaraidsas
  extraDimensions:
    script: check_megaraidsas
  telegrafParser:
    dataFormat: nagios
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| detectors\_disabled | Disable all detectors in this module | bool | `"false"` | no |
| environment | Infrastructure environment | string | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | list | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | list | `[]` | no |
| notifications | Notification recipients list for every detectors | list | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | list | `[]` | no |
| status\_check\_aggregation\_function | Aggregation function and group by for status\_check detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| status\_check\_disabled | Disable all alerting rules for status\_check detector | bool | `"null"` | no |
| status\_check\_disabled\_critical | Disable critical alerting rule for status\_check detector | bool | `"null"` | no |
| status\_check\_disabled\_major | Disable major alerting rule for status\_check detector | bool | `"null"` | no |
| status\_check\_disabled\_warning | Disable warning alerting rule for status\_check detector | bool | `"null"` | no |
| status\_check\_lasting\_duration\_seconds | Minimum duration that conditions must be true before raising alert \(in seconds\) | string | `"900"` | no |
| status\_check\_notifications | Notification recipients list for every alerting rules of status\_check detector | list | `[]` | no |
| status\_check\_notifications\_critical | Notification recipients list for critical alerting rule of status\_check detector | list | `[]` | no |
| status\_check\_notifications\_major | Notification recipients list for major alerting rule of status\_check detector | list | `[]` | no |
| status\_check\_notifications\_warning | Notification recipients list for warning alerting rule of status\_check detector | list | `[]` | no |
| status\_check\_transformation\_function | Transformation function for status\_check detector \(i.e. ".mean\(over='5m'\)"\) | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| status\_check\_id | id for detector status\_check |

## Related documentation

- [Official documentation for the telegraf exec plugin](https://docs.signalfx.com/en/latest/integrations/agent/monitors/telegraf-exec.html)
- [Nagios documentation](https://nagios-plugins.org/doc/guidelines.html#AEN78)
- [Telegraf exec plugin](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/exec)
- [Telegraf nagios parser](https://github.com/influxdata/telegraf/tree/master/plugins/parsers/nagios)

