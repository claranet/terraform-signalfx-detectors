# MIDDLEWARE SUPERVISOR SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-middleware-supervisor" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//middleware/supervisor?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

```

## Purpose

Creates SignalFx detectors with the following checks:

- Supervisor process state
- Supervisor heartbeat

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| detectors\_disabled | Disable all detectors in this module | bool | `"false"` | no |
| environment | Infrastructure environment | string | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | list | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | list | `[]` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | bool | `"null"` | no |
| heartbeat\_notifications | Notification recipients list for every alerting rules of heartbeat detector | list | `[]` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector \(i.e. "10m"\) | string | `"20m"` | no |
| notifications | Notification recipients list for every detectors | list | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | list | `[]` | no |
| process\_state\_aggregation\_function | Aggregation function and group by for process state detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| process\_state\_disabled | Disable all alerting rules for process state detector | bool | `"null"` | no |
| process\_state\_disabled\_critical | Disable critical alerting rule for process state detector | bool | `"null"` | no |
| process\_state\_disabled\_warning | Disable warning alerting rule for process state detector | bool | `"null"` | no |
| process\_state\_notifications | Notification recipients list for every alerting rules of process state detector | list | `[]` | no |
| process\_state\_notifications\_critical | Notification recipients list for critical alerting rule of process state detector | list | `[]` | no |
| process\_state\_notifications\_warning | Notification recipients list for warning alerting rule of process state detector | list | `[]` | no |
| process\_state\_threshold\_critical | Critical threshold for process state detector, see http://supervisord.org/subprocess.html#process-states\) | number | `"20"` | no |
| process\_state\_threshold\_warning | Warning threshold for process state detector \(default to be less then 20 \(process has been stopped manually or is starting\), see http://supervisord.org/subprocess.html#process-states | number | `"20"` | no |
| process\_state\_transformation\_function | Transformation function for process state detector \(mean, min, max\) | string | `"min"` | no |
| process\_state\_transformation\_window | Transformation window for process state detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"10m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| heartbeat\_id | id for detector heartbeat |
| process\_state\_id | id for detector process state |

## Related documentation

[Official documentation for supervisor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/supervisor.html)
[Supervisor state definition](http://supervisord.org/subprocess.html#process-states)
