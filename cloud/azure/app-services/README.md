# CLOUD AZURE APP-SERVICES SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-cloud-azure-app-services" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//cloud/azure/app-services?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

```

## Purpose

Creates SignalFx detectors with the following checks:

- App Services HTTP 4xx errors too high
- App Services HTTP 5xx errors too high
- App Services HTTP successful responses too low
- App Services is down
- App Services memory usage
- App Services response time too high

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| environment | Infrastructure environment | `string` | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | `list` | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | `list` | `[]` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | `bool` | `null` | no |
| heartbeat\_notifications | Notification recipients list for every alerting rules of heartbeat detector | `list` | `[]` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector (i.e. "10m") | `string` | `"20m"` | no |
| http\_4xx\_errors\_count\_aggregation\_function | Aggregation function and group by for http\_4xx\_errors\_count detector (i.e. ".mean(by=['host'])") | `string` | `".mean(by=['Instance', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"` | no |
| http\_4xx\_errors\_count\_aperiodic\_duration | Duration for the http\_4xx\_errors\_count block | `string` | `"10m"` | no |
| http\_4xx\_errors\_count\_aperiodic\_percentage | Percentage for the http\_4xx\_errors\_count block | `number` | `0.9` | no |
| http\_4xx\_errors\_count\_disabled | Disable all alerting rules for http\_4xx\_errors\_count detector | `bool` | `null` | no |
| http\_4xx\_errors\_count\_disabled\_critical | Disable critical alerting rule for http\_4xx\_errors\_count detector | `bool` | `null` | no |
| http\_4xx\_errors\_count\_disabled\_warning | Disable warning alerting rule for http\_4xx\_errors\_count detector | `bool` | `null` | no |
| http\_4xx\_errors\_count\_notifications | Notification recipients list for every alerting rules of http\_4xx\_errors\_count detector | `list` | `[]` | no |
| http\_4xx\_errors\_count\_notifications\_critical | Notification recipients list for critical alerting rule of http\_4xx\_errors\_count detector | `list` | `[]` | no |
| http\_4xx\_errors\_count\_notifications\_warning | Notification recipients list for warning alerting rule of http\_4xx\_errors\_count detector | `list` | `[]` | no |
| http\_4xx\_errors\_count\_threshold\_critical | Critical threshold for http\_4xx\_errors\_count detector | `number` | `90` | no |
| http\_4xx\_errors\_count\_threshold\_warning | Warning threshold for http\_4xx\_errors\_count detector | `number` | `50` | no |
| http\_4xx\_errors\_count\_transformation\_function | Transformation function for http\_4xx\_errors\_count detector (mean, min, max) | `string` | `"min"` | no |
| http\_4xx\_errors\_count\_transformation\_window | Transformation window for http\_4xx\_errors\_count detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| http\_5xx\_errors\_count\_aggregation\_function | Aggregation function and group by for http\_5xx\_errors\_count detector (i.e. ".mean(by=['host'])") | `string` | `".mean(by=['Instance', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"` | no |
| http\_5xx\_errors\_count\_aperiodic\_duration | Duration for the http\_5xx\_errors\_count block | `string` | `"10m"` | no |
| http\_5xx\_errors\_count\_aperiodic\_percentage | Percentage for the http\_5xx\_errors\_count block | `number` | `0.9` | no |
| http\_5xx\_errors\_count\_disabled | Disable all alerting rules for http\_5xx\_errors\_count detector | `bool` | `null` | no |
| http\_5xx\_errors\_count\_disabled\_critical | Disable critical alerting rule for http\_5xx\_errors\_count detector | `bool` | `null` | no |
| http\_5xx\_errors\_count\_disabled\_warning | Disable warning alerting rule for http\_5xx\_errors\_count detector | `bool` | `null` | no |
| http\_5xx\_errors\_count\_notifications | Notification recipients list for every alerting rules of http\_5xx\_errors\_count detector | `list` | `[]` | no |
| http\_5xx\_errors\_count\_notifications\_critical | Notification recipients list for critical alerting rule of http\_5xx\_errors\_count detector | `list` | `[]` | no |
| http\_5xx\_errors\_count\_notifications\_warning | Notification recipients list for warning alerting rule of http\_5xx\_errors\_count detector | `list` | `[]` | no |
| http\_5xx\_errors\_count\_threshold\_critical | Critical threshold for http\_5xx\_errors\_count detector | `number` | `90` | no |
| http\_5xx\_errors\_count\_threshold\_warning | Warning threshold for http\_5xx\_errors\_count detector | `number` | `50` | no |
| http\_5xx\_errors\_count\_transformation\_function | Transformation function for http\_5xx\_errors\_count detector (mean, min, max) | `string` | `"min"` | no |
| http\_5xx\_errors\_count\_transformation\_window | Transformation window for http\_5xx\_errors\_count detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| http\_success\_status\_rate\_aggregation\_function | Aggregation function and group by for http\_success\_status\_rate detector (i.e. ".mean(by=['host'])") | `string` | `".mean(by=['Instance', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"` | no |
| http\_success\_status\_rate\_aperiodic\_duration | Duration for the http\_success\_status\_rate block | `string` | `"10m"` | no |
| http\_success\_status\_rate\_aperiodic\_percentage | Percentage for the http\_success\_status\_rate block | `number` | `0.9` | no |
| http\_success\_status\_rate\_disabled | Disable all alerting rules for http\_success\_status\_rate detector | `bool` | `null` | no |
| http\_success\_status\_rate\_disabled\_critical | Disable critical alerting rule for http\_success\_status\_rate detector | `bool` | `null` | no |
| http\_success\_status\_rate\_disabled\_warning | Disable warning alerting rule for http\_success\_status\_rate detector | `bool` | `null` | no |
| http\_success\_status\_rate\_notifications | Notification recipients list for every alerting rules of http\_success\_status\_rate detector | `list` | `[]` | no |
| http\_success\_status\_rate\_notifications\_critical | Notification recipients list for critical alerting rule of http\_success\_status\_rate detector | `list` | `[]` | no |
| http\_success\_status\_rate\_notifications\_warning | Notification recipients list for warning alerting rule of http\_success\_status\_rate detector | `list` | `[]` | no |
| http\_success\_status\_rate\_threshold\_critical | Critical threshold for http\_success\_status\_rate detector | `number` | `10` | no |
| http\_success\_status\_rate\_threshold\_warning | Warning threshold for http\_success\_status\_rate detector | `number` | `30` | no |
| http\_success\_status\_rate\_transformation\_function | Transformation function for http\_success\_status\_rate detector (mean, min, max) | `string` | `"max"` | no |
| http\_success\_status\_rate\_transformation\_window | Transformation window for http\_success\_status\_rate detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| memory\_usage\_count\_aggregation\_function | Aggregation function and group by for memory\_usage\_count detector (i.e. ".mean(by=['host'])") | `string` | `".mean(by=['Instance', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"` | no |
| memory\_usage\_count\_disabled | Disable all alerting rules for memory\_usage\_count detector | `bool` | `null` | no |
| memory\_usage\_count\_disabled\_critical | Disable critical alerting rule for memory\_usage\_count detector | `bool` | `null` | no |
| memory\_usage\_count\_disabled\_warning | Disable warning alerting rule for memory\_usage\_count detector | `bool` | `null` | no |
| memory\_usage\_count\_notifications | Notification recipients list for every alerting rules of memory\_usage\_count detector | `list` | `[]` | no |
| memory\_usage\_count\_notifications\_critical | Notification recipients list for critical alerting rule of memory\_usage\_count detector | `list` | `[]` | no |
| memory\_usage\_count\_notifications\_warning | Notification recipients list for warning alerting rule of memory\_usage\_count detector | `list` | `[]` | no |
| memory\_usage\_count\_threshold\_critical | Critical threshold for memory\_usage\_count detector | `number` | `1073741824` | no |
| memory\_usage\_count\_threshold\_warning | Warning threshold for memory\_usage\_count detector | `number` | `536870912` | no |
| memory\_usage\_count\_transformation\_function | Transformation function for memory\_usage\_count detector (mean, min, max) | `string` | `"min"` | no |
| memory\_usage\_count\_transformation\_window | Transformation window for memory\_usage\_count detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| notifications | Notification recipients list for every detectors | `list` | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |
| response\_time\_aggregation\_function | Aggregation function and group by for response\_time detector (i.e. ".mean(by=['host'])") | `string` | `".mean(by=['Instance', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"` | no |
| response\_time\_aperiodic\_duration | Duration for the response\_time block | `string` | `"10m"` | no |
| response\_time\_aperiodic\_percentage | Percentage for the response\_time block | `number` | `0.9` | no |
| response\_time\_disabled | Disable all alerting rules for response\_time detector | `bool` | `null` | no |
| response\_time\_disabled\_critical | Disable critical alerting rule for response\_time detector | `bool` | `null` | no |
| response\_time\_disabled\_warning | Disable warning alerting rule for response\_time detector | `bool` | `null` | no |
| response\_time\_notifications | Notification recipients list for every alerting rules of response\_time detector | `list` | `[]` | no |
| response\_time\_notifications\_critical | Notification recipients list for critical alerting rule of response\_time detector | `list` | `[]` | no |
| response\_time\_notifications\_warning | Notification recipients list for warning alerting rule of response\_time detector | `list` | `[]` | no |
| response\_time\_threshold\_critical | Critical threshold for response\_time detector | `number` | `10` | no |
| response\_time\_threshold\_warning | Warning threshold for response\_time detector | `number` | `5` | no |
| response\_time\_transformation\_function | Transformation function for response\_time detector (mean, min, max) | `string` | `"min"` | no |
| response\_time\_transformation\_window | Transformation window for response\_time detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| heartbeat\_id | id for detector heartbeat |
| http\_4xx\_errors\_count\_id | id for detector http\_4xx\_errors\_count |
| http\_5xx\_errors\_count\_id | id for detector http\_5xx\_errors\_count |
| http\_success\_status\_rate\_id | id for detector http\_success\_status\_rate |
| memory\_usage\_count\_id | id for detector memory\_usage\_count |
| response\_time\_id | id for detector response\_time |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/azure-info.html)
[Azure monitor documenation](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported)
