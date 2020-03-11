# SYSTEM GENERIC SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-system-generic" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//system/generic?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

```

## Purpose

Creates SignalFx detectors with the following checks:

- System cpu utilization
- System disk inodes utilization
- System disk space running out
- System disk space utilization
- System heartbeat
- System load 5m ratio
- System memory utilization

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cpu\_aggregation\_function | Aggregation function and group by for cpu detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| cpu\_disabled | Disable all alerting rules for cpu detector | `bool` | n/a | yes |
| cpu\_disabled\_critical | Disable critical alerting rule for cpu detector | `bool` | n/a | yes |
| cpu\_disabled\_warning | Disable warning alerting rule for cpu detector | `bool` | n/a | yes |
| cpu\_notifications | Notification recipients list for every alerting rules of cpu detector | `list` | `[]` | no |
| cpu\_notifications\_critical | Notification recipients list for critical alerting rule of cpu detector | `list` | `[]` | no |
| cpu\_notifications\_warning | Notification recipients list for warning alerting rule of cpu detector | `list` | `[]` | no |
| cpu\_threshold\_critical | Critical threshold for cpu detector | `number` | `90` | no |
| cpu\_threshold\_warning | Warning threshold for cpu detector | `number` | `85` | no |
| cpu\_transformation\_function | Transformation function for cpu detector (mean, min, max) | `string` | `"min"` | no |
| cpu\_transformation\_window | Transformation window for cpu detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"1h"` | no |
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| disk\_inodes\_aggregation\_function | Aggregation function and group by for disk\_inodes detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| disk\_inodes\_disabled | Disable all alerting rules for disk\_inodes detector | `bool` | n/a | yes |
| disk\_inodes\_disabled\_critical | Disable critical alerting rule for disk\_inodes detector | `bool` | n/a | yes |
| disk\_inodes\_disabled\_warning | Disable warning alerting rule for dsik\_inodes detector | `bool` | n/a | yes |
| disk\_inodes\_notifications | Notification recipients list for every alerting rules of disk\_inodes detector | `list` | `[]` | no |
| disk\_inodes\_notifications\_critical | Notification recipients list for critical alerting rule of disk\_inodes detector | `list` | `[]` | no |
| disk\_inodes\_notifications\_warning | Notification recipients list for warning alerting rule of disk\_inodes detector | `list` | `[]` | no |
| disk\_inodes\_threshold\_critical | Critical threshold for disk\_inodes detector | `number` | `95` | no |
| disk\_inodes\_threshold\_warning | Warning threshold for disk\_inodes detector | `number` | `90` | no |
| disk\_inodes\_transformation\_function | Transformation function for disk\_inodes detector (mean, min, max) | `string` | `"min"` | no |
| disk\_inodes\_transformation\_window | Transformation window for disk\_inodes detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| disk\_running\_out\_clear\_hours\_remaining | With how many hours left till disk is full can the alert clear | `number` | `96` | no |
| disk\_running\_out\_clear\_lasting\_time | Time clear condition must be true to clear | `string` | `"30m"` | no |
| disk\_running\_out\_clear\_lasting\_time\_percent | Percent of clear lasting time the conditon must be true.  Expressed as decimal | `number` | `0.9` | no |
| disk\_running\_out\_disabled | Disable all alerting rules for disk running out detector | `bool` | n/a | yes |
| disk\_running\_out\_fire\_lasting\_time | Time condition must be true to fire | `string` | `"30m"` | no |
| disk\_running\_out\_fire\_lasting\_time\_percent | Percent of fire lasting time the conditon must be true.  Expressed as decimal | `number` | `0.9` | no |
| disk\_running\_out\_hours\_till\_full | How manuy hours before disk is projected to be full do you want to be alerted | `number` | `72` | no |
| disk\_running\_out\_maximum\_capacity | When to consider disk full, defined as a percentage | `number` | `95` | no |
| disk\_running\_out\_notifications | Notification recipients list for every alerting rules of disk running out detector | `list` | `[]` | no |
| disk\_running\_out\_use\_ewma | Use Double EWMA | `bool` | `false` | no |
| disk\_space\_aggregation\_function | Aggregation function and group by for disk space detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| disk\_space\_disabled | Disable all alerting rules for disk space detector | `bool` | n/a | yes |
| disk\_space\_disabled\_critical | Disable critical alerting rule for disk space detector | `bool` | n/a | yes |
| disk\_space\_disabled\_warning | Disable warning alerting rule for disk space detector | `bool` | n/a | yes |
| disk\_space\_notifications | Notification recipients list for every alerting rules of disk space detector | `list` | `[]` | no |
| disk\_space\_notifications\_critical | Notification recipients list for critical alerting rule of disk space detector | `list` | `[]` | no |
| disk\_space\_notifications\_warning | Notification recipients list for warning alerting rule of disk space detector | `list` | `[]` | no |
| disk\_space\_threshold\_critical | Critical threshold for disk space detector | `number` | `90` | no |
| disk\_space\_threshold\_warning | Warning threshold for disk space detector | `number` | `80` | no |
| disk\_space\_transformation\_function | Transformation function for disk space detector (mean, min, max) | `string` | `"max"` | no |
| disk\_space\_transformation\_window | Transformation window for disk space detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| environment | Infrastructure environment | `string` | n/a | yes |
| filter\_custom\_excludes | Tags to exclude when using custom filtering (i.e "tag1:val1;tag2:val2") | `string` | `""` | no |
| filter\_custom\_includes | Tags to filter signals on when custom filtering is used (i.e "tag1:val1;tag2:val2") | `string` | `""` | no |
| filter\_use\_defaults | Use default filtering which follows tagging convention | `bool` | `true` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | `bool` | n/a | yes |
| heartbeat\_notifications | Notification recipients list for every alerting rules of heartbeat detector | `list` | `[]` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector (i.e. "10m") | `string` | `"20m"` | no |
| load\_aggregation\_function | Aggregation function and group by for load detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| load\_disabled | Disable all alerting rules for load detector | `bool` | n/a | yes |
| load\_disabled\_critical | Disable critical alerting rule for load detector | `bool` | n/a | yes |
| load\_disabled\_warning | Disable warning alerting rule for load detector | `bool` | n/a | yes |
| load\_notifications | Notification recipients list for every alerting rules of load detector | `list` | `[]` | no |
| load\_notifications\_critical | Notification recipients list for critical alerting rule of load detector | `list` | `[]` | no |
| load\_notifications\_warning | Notification recipients list for warning alerting rule of load detector | `list` | `[]` | no |
| load\_threshold\_critical | Critical threshold for load detector | `number` | `2.5` | no |
| load\_threshold\_warning | Warning threshold for load detector | `number` | `2` | no |
| load\_transformation\_function | Transformation function for load detector (mean, min, max) | `string` | `"min"` | no |
| load\_transformation\_window | Transformation window for load detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"30m"` | no |
| memory\_aggregation\_function | Aggregation function and group by for memory detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| memory\_disabled | Disable all alerting rules for memory detector | `bool` | n/a | yes |
| memory\_disabled\_critical | Disable critical alerting rule for memory detector | `bool` | n/a | yes |
| memory\_disabled\_warning | Disable warning alerting rule for memory detector | `bool` | n/a | yes |
| memory\_notifications | Notification recipients list for every alerting rules of memory detector | `list` | `[]` | no |
| memory\_notifications\_critical | Notification recipients list for critical alerting rule of memory detector | `list` | `[]` | no |
| memory\_notifications\_warning | Notification recipients list for warning alerting rule of memory detector | `list` | `[]` | no |
| memory\_threshold\_critical | Critical threshold for memory detector | `number` | `95` | no |
| memory\_threshold\_warning | Warning threshold for memory detector | `number` | `90` | no |
| memory\_transformation\_function | Transformation function for memory detector (mean, min, max) | `string` | `"min"` | no |
| memory\_transformation\_window | Transformation window for memory detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| notifications | Notification recipients list (i.e. "Email,my@mail.com;PagerDuty,credentialId") | `list` | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| cpu\_id | id for detector cpu |
| disk\_running\_out\_id | id for detector disk running out |
| disk\_space\_id | id for detector disk space |
| heartbeat\_id | id for detector heartbeat |
| load\_id | id for detector load |
| memory\_id | id for detector memory |

## Related documentation

[Official documentation for host-metadata](https://docs.signalfx.com/en/latest/integrations/agent/monitors/host-metadata.html)
[Official documentation for cpu](https://docs.signalfx.com/en/latest/integrations/agent/monitors/cpu.html)
[Official documentation for load](https://docs.signalfx.com/en/latest/integrations/agent/monitors/load.html)
[Official documentation for filesystems](https://docs.signalfx.com/en/latest/integrations/agent/monitors/filesystems.html)
[Official documentation memory](https://docs.signalfx.com/en/latest/integrations/agent/monitors/memory.html)

## Notes

* Concerning load detector:

You will need to define `perCPU` in `load` monitor options to get the **ratio** of load per CPU/core.

* Concerning disk inodes detector:

You will need to add `inodes` metric group in `extraGroups` in `filesystems` monitor options to get inodes related metrics (counted as custom metrics and only available for linux).
