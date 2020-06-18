# SYSTEM PROCESSES SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-system-processes" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//system/processes?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

```

## Purpose

Creates SignalFx detectors with the following checks:

- Processes aliveness

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| processes\_aggregation\_function | Aggregation function and group by for processes detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| processes\_disabled | Disable all alerting rules for processes detector | `bool` | n/a | yes |
| processes\_disabled\_critical | Disable critical alerting rule for processes detector | `bool` | n/a | yes |
| processes\_disabled\_warning | Disable warning alerting rule for processes detector | `true` | n/a | yes |
| processes\_notifications | Notification recipients list for every alerting rules of processes detector | `list` | `[]` | no |
| processes\_notifications\_critical | Notification recipients list for critical alerting rule of processes detector | `list` | `[]` | no |
| processes\_notifications\_warning | Notification recipients list for warning alerting rule of processes detector | `list` | `[]` | no |
| processes\_threshold\_critical | Critical threshold for processes detector | `number` | `1` | no |
| processes\_threshold\_warning | Warning threshold for processes detector | `number` | `1` | no |
| processes\_transformation\_function | Transformation function for processes detector (mean, min, max) | `string` | `"min"` | no |
| processes\_transformation\_window | Transformation window for processes detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"15min"` | no |
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| environment | Infrastructure environment | `string` | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | `list` | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | `list` | `[]` | no |
| notifications | Notification recipients list for every detectors | `list` | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| processes\_id | id for detector processes |

## Related documentation

[Official documentation for processes](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-processes.html)

## Notes

By default, this detectors will check if a process is present or not. 

The "warning" state can be enable if you need to check if a process need a minimal amount of process running.
Ex: I need 5 "foo" processes for my api to run correctly, so I will put in warning 5 and in critical 1. 
In that case, "warning" will raise if I’m under 5 processes and "critical" if no process is found.
