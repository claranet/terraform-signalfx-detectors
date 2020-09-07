# CLOUD AZURE APP-GATEWAY SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-cloud-azure-app-gateway" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//cloud/azure/app-gateway?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

```

## Purpose

Creates SignalFx detectors with the following checks:

- App Gateway backend connect time is too high
- App Gateway backend HTTP 4xx errors rate is too high
- App Gateway backend HTTP 5xx errors rate is too high
- App Gateway backend unhealthy host ratio is too high
- App Gateway failed requests
- App Gateway has no requests
- App Gateway HTTP 4xx errors rate is too high
- App Gateway HTTP 5xx errors rate is too high
- App Gateway is down

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_connect\_time\_aggregation\_function | Aggregation function and group by for backend\_connect\_time detector (i.e. ".mean(by=['host'])") | `string` | `".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendhttpsetting', 'backendpool', 'backendserver'])"` | no |
| backend\_connect\_time\_disabled | Disable all alerting rules for backend\_connect\_time detector | `bool` | `null` | no |
| backend\_connect\_time\_disabled\_critical | Disable critical alerting rule for backend\_connect\_time detector | `bool` | `null` | no |
| backend\_connect\_time\_disabled\_warning | Disable warning alerting rule for backend\_connect\_time detector | `bool` | `null` | no |
| backend\_connect\_time\_notifications | Notification recipients list for every alerting rules of backend\_connect\_time detector | `list` | `[]` | no |
| backend\_connect\_time\_notifications\_critical | Notification recipients list for critical alerting rule of backend\_connect\_time detector | `list` | `[]` | no |
| backend\_connect\_time\_notifications\_warning | Notification recipients list for warning alerting rule of backend\_connect\_time detector | `list` | `[]` | no |
| backend\_connect\_time\_threshold\_critical | Critical threshold for backend\_connect\_time detector | `number` | `50` | no |
| backend\_connect\_time\_threshold\_warning | Warning threshold for backend\_connect\_time detector | `number` | `40` | no |
| backend\_connect\_time\_transformation\_function | Transformation function for backend\_connect\_time detector (mean, min, max) | `string` | `"min"` | no |
| backend\_connect\_time\_transformation\_window | Transformation window for backend\_connect\_time detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| backend\_http\_4xx\_errors\_aggregation\_function | Aggregation function and group by for backend\_http\_4xx\_errors detector (i.e. ".mean(by=['host'])") | `string` | `".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendhttpsetting', 'backendpool', 'backendserver'])"` | no |
| backend\_http\_4xx\_errors\_aperiodic\_duration | Duration for the backend\_http\_4xx\_errors block | `string` | `"10m"` | no |
| backend\_http\_4xx\_errors\_aperiodic\_percentage | Percentage for the backend\_http\_4xx\_errors block | `number` | `0.9` | no |
| backend\_http\_4xx\_errors\_clear\_duration | Duration for the backend\_http\_4xx\_errors clear condition | `string` | `"15m"` | no |
| backend\_http\_4xx\_errors\_disabled | Disable all alerting rules for backend\_http\_4xx\_errors detector | `bool` | `null` | no |
| backend\_http\_4xx\_errors\_disabled\_critical | Disable critical alerting rule for backend\_http\_4xx\_errors detector | `bool` | `null` | no |
| backend\_http\_4xx\_errors\_disabled\_warning | Disable warning alerting rule for backend\_http\_4xx\_errors detector | `bool` | `null` | no |
| backend\_http\_4xx\_errors\_notifications | Notification recipients list for every alerting rules of backend\_http\_4xx\_errors detector | `list` | `[]` | no |
| backend\_http\_4xx\_errors\_notifications\_critical | Notification recipients list for critical alerting rule of backend\_http\_4xx\_errors detector | `list` | `[]` | no |
| backend\_http\_4xx\_errors\_notifications\_warning | Notification recipients list for warning alerting rule of backend\_http\_4xx\_errors detector | `list` | `[]` | no |
| backend\_http\_4xx\_errors\_threshold\_critical | Critical threshold for backend\_http\_4xx\_errors detector | `number` | `95` | no |
| backend\_http\_4xx\_errors\_threshold\_warning | Warning threshold for backend\_http\_4xx\_errors detector | `number` | `80` | no |
| backend\_http\_4xx\_errors\_transformation\_function | Transformation function for backend\_http\_4xx\_errors detector (mean, min, max) | `string` | `"min"` | no |
| backend\_http\_4xx\_errors\_transformation\_window | Transformation window for backend\_http\_4xx\_errors detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| backend\_http\_5xx\_errors\_aggregation\_function | Aggregation function and group by for backend\_http\_5xx\_errors detector (i.e. ".mean(by=['host'])") | `string` | `".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendhttpsetting', 'backendpool', 'backendserver'])"` | no |
| backend\_http\_5xx\_errors\_aperiodic\_duration | Duration for the backend\_http\_5xx\_errors block | `string` | `"10m"` | no |
| backend\_http\_5xx\_errors\_aperiodic\_percentage | Percentage for the backend\_http\_5xx\_errors block | `number` | `0.9` | no |
| backend\_http\_5xx\_errors\_clear\_duration | Duration for the backend\_http\_5xx\_errors clear condition | `string` | `"15m"` | no |
| backend\_http\_5xx\_errors\_disabled | Disable all alerting rules for backend\_http\_5xx\_errors detector | `bool` | `null` | no |
| backend\_http\_5xx\_errors\_disabled\_critical | Disable critical alerting rule for backend\_http\_5xx\_errors detector | `bool` | `null` | no |
| backend\_http\_5xx\_errors\_disabled\_warning | Disable warning alerting rule for backend\_http\_5xx\_errors detector | `bool` | `null` | no |
| backend\_http\_5xx\_errors\_notifications | Notification recipients list for every alerting rules of backend\_http\_5xx\_errors detector | `list` | `[]` | no |
| backend\_http\_5xx\_errors\_notifications\_critical | Notification recipients list for critical alerting rule of backend\_http\_5xx\_errors detector | `list` | `[]` | no |
| backend\_http\_5xx\_errors\_notifications\_warning | Notification recipients list for warning alerting rule of backend\_http\_5xx\_errors detector | `list` | `[]` | no |
| backend\_http\_5xx\_errors\_threshold\_critical | Critical threshold for backend\_http\_5xx\_errors detector | `number` | `95` | no |
| backend\_http\_5xx\_errors\_threshold\_warning | Warning threshold for backend\_http\_5xx\_errors detector | `number` | `80` | no |
| backend\_http\_5xx\_errors\_transformation\_function | Transformation function for backend\_http\_5xx\_errors detector (mean, min, max) | `string` | `"min"` | no |
| backend\_http\_5xx\_errors\_transformation\_window | Transformation window for backend\_http\_5xx\_errors detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| environment | Infrastructure environment | `string` | n/a | yes |
| failed\_requests\_aggregation\_function | Aggregation function and group by for failed\_requests detector (i.e. ".mean(by=['host'])") | `string` | `".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendsettingspool'])"` | no |
| failed\_requests\_aperiodic\_duration | Duration for the failed\_requests block | `string` | `"10m"` | no |
| failed\_requests\_aperiodic\_percentage | Percentage for the failed\_requests block | `number` | `0.9` | no |
| failed\_requests\_disabled | Disable all alerting rules for failed\_requests detector | `bool` | `null` | no |
| failed\_requests\_disabled\_critical | Disable critical alerting rule for failed\_requests detector | `bool` | `null` | no |
| failed\_requests\_disabled\_warning | Disable warning alerting rule for failed\_requests detector | `bool` | `null` | no |
| failed\_requests\_notifications | Notification recipients list for every alerting rules of failed\_requests detector | `list` | `[]` | no |
| failed\_requests\_notifications\_critical | Notification recipients list for critical alerting rule of failed\_requests detector | `list` | `[]` | no |
| failed\_requests\_notifications\_warning | Notification recipients list for warning alerting rule of failed\_requests detector | `list` | `[]` | no |
| failed\_requests\_threshold\_critical | Critical threshold for failed\_requests detector | `number` | `95` | no |
| failed\_requests\_threshold\_warning | Warning threshold for failed\_requests detector | `number` | `80` | no |
| failed\_requests\_transformation\_function | Transformation function for failed\_requests detector (mean, min, max) | `string` | `"min"` | no |
| failed\_requests\_transformation\_window | Transformation window for failed\_requests detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | `list` | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | `list` | `[]` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | `bool` | `null` | no |
| heartbeat\_notifications | Notification recipients list for every alerting rules of heartbeat detector | `list` | `[]` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector (i.e. "10m") | `string` | `"20m"` | no |
| http\_4xx\_errors\_aggregation\_function | Aggregation function and group by for http\_4xx\_errors detector (i.e. ".mean(by=['host'])") | `string` | `".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"` | no |
| http\_4xx\_errors\_aperiodic\_duration | Duration for the http\_4xx\_errors block | `string` | `"10m"` | no |
| http\_4xx\_errors\_aperiodic\_percentage | Percentage for the http\_4xx\_errors block | `number` | `0.9` | no |
| http\_4xx\_errors\_clear\_duration | Duration for the http\_4xx\_errors clear condition | `string` | `"15m"` | no |
| http\_4xx\_errors\_disabled | Disable all alerting rules for http\_4xx\_errors detector | `bool` | `null` | no |
| http\_4xx\_errors\_disabled\_critical | Disable critical alerting rule for http\_4xx\_errors detector | `bool` | `null` | no |
| http\_4xx\_errors\_disabled\_warning | Disable warning alerting rule for http\_4xx\_errors detector | `bool` | `null` | no |
| http\_4xx\_errors\_notifications | Notification recipients list for every alerting rules of http\_4xx\_errors detector | `list` | `[]` | no |
| http\_4xx\_errors\_notifications\_critical | Notification recipients list for critical alerting rule of http\_4xx\_errors detector | `list` | `[]` | no |
| http\_4xx\_errors\_notifications\_warning | Notification recipients list for warning alerting rule of http\_4xx\_errors detector | `list` | `[]` | no |
| http\_4xx\_errors\_threshold\_critical | Critical threshold for http\_4xx\_errors detector | `number` | `95` | no |
| http\_4xx\_errors\_threshold\_warning | Warning threshold for http\_4xx\_errors detector | `number` | `80` | no |
| http\_4xx\_errors\_transformation\_function | Transformation function for http\_4xx\_errors detector (mean, min, max) | `string` | `"min"` | no |
| http\_4xx\_errors\_transformation\_window | Transformation window for http\_4xx\_errors detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| http\_5xx\_errors\_aggregation\_function | Aggregation function and group by for http\_5xx\_errors detector (i.e. ".mean(by=['host'])") | `string` | `".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"` | no |
| http\_5xx\_errors\_aperiodic\_duration | Duration for the http\_5xx\_errors block | `string` | `"10m"` | no |
| http\_5xx\_errors\_aperiodic\_percentage | Percentage for the http\_5xx\_errors block | `number` | `0.9` | no |
| http\_5xx\_errors\_clear\_duration | Duration for the http\_5xx\_errors clear condition | `string` | `"15m"` | no |
| http\_5xx\_errors\_disabled | Disable all alerting rules for http\_5xx\_errors detector | `bool` | `null` | no |
| http\_5xx\_errors\_disabled\_critical | Disable critical alerting rule for http\_5xx\_errors detector | `bool` | `null` | no |
| http\_5xx\_errors\_disabled\_warning | Disable warning alerting rule for http\_5xx\_errors detector | `bool` | `null` | no |
| http\_5xx\_errors\_notifications | Notification recipients list for every alerting rules of http\_5xx\_errors detector | `list` | `[]` | no |
| http\_5xx\_errors\_notifications\_critical | Notification recipients list for critical alerting rule of http\_5xx\_errors detector | `list` | `[]` | no |
| http\_5xx\_errors\_notifications\_warning | Notification recipients list for warning alerting rule of http\_5xx\_errors detector | `list` | `[]` | no |
| http\_5xx\_errors\_threshold\_critical | Critical threshold for http\_5xx\_errors detector | `number` | `95` | no |
| http\_5xx\_errors\_threshold\_warning | Warning threshold for http\_5xx\_errors detector | `number` | `80` | no |
| http\_5xx\_errors\_transformation\_function | Transformation function for http\_5xx\_errors detector (mean, min, max) | `string` | `"min"` | no |
| http\_5xx\_errors\_transformation\_window | Transformation window for http\_5xx\_errors detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| notifications | Notification recipients list for every detectors | `list` | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |
| total\_requests\_aggregation\_function | Aggregation function and group by for total\_requests detector (i.e. ".mean(by=['host'])") | `string` | `".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"` | no |
| total\_requests\_disabled | Disable all alerting rules for total\_requests detector | `bool` | `null` | no |
| total\_requests\_disabled\_critical | Disable critical alerting rule for total\_requests detector | `bool` | `null` | no |
| total\_requests\_disabled\_warning | Disable warning alerting rule for total\_requests detector | `bool` | `null` | no |
| total\_requests\_notifications | Notification recipients list for every alerting rules of total\_requests detector | `list` | `[]` | no |
| total\_requests\_notifications\_critical | Notification recipients list for critical alerting rule of total\_requests detector | `list` | `[]` | no |
| total\_requests\_notifications\_warning | Notification recipients list for warning alerting rule of total\_requests detector | `list` | `[]` | no |
| total\_requests\_threshold\_critical | Critical threshold for total\_requests detector | `number` | `1` | no |
| total\_requests\_transformation\_function | Transformation function for total\_requests detector (mean, min, max) | `string` | `"max"` | no |
| total\_requests\_transformation\_window | Transformation window for total\_requests detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| unhealthy\_host\_ratio\_aggregation\_function | Aggregation function and group by for unhealthy\_host\_ratio detector (i.e. ".mean(by=['host'])") | `string` | `".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region', 'backendsettingspool'])"` | no |
| unhealthy\_host\_ratio\_disabled | Disable all alerting rules for unhealthy\_host\_ratio detector | `bool` | `null` | no |
| unhealthy\_host\_ratio\_disabled\_critical | Disable critical alerting rule for unhealthy\_host\_ratio detector | `bool` | `null` | no |
| unhealthy\_host\_ratio\_disabled\_warning | Disable warning alerting rule for unhealthy\_host\_ratio detector | `bool` | `null` | no |
| unhealthy\_host\_ratio\_notifications | Notification recipients list for every alerting rules of unhealthy\_host\_ratio detector | `list` | `[]` | no |
| unhealthy\_host\_ratio\_notifications\_critical | Notification recipients list for critical alerting rule of unhealthy\_host\_ratio detector | `list` | `[]` | no |
| unhealthy\_host\_ratio\_notifications\_warning | Notification recipients list for warning alerting rule of unhealthy\_host\_ratio detector | `list` | `[]` | no |
| unhealthy\_host\_ratio\_threshold\_critical | Critical threshold for unhealthy\_host\_ratio detector | `number` | `75` | no |
| unhealthy\_host\_ratio\_threshold\_warning | Warning threshold for unhealthy\_host\_ratio detector | `number` | `50` | no |
| unhealthy\_host\_ratio\_transformation\_function | Transformation function for unhealthy\_host\_ratio detector (mean, min, max) | `string` | `"min"` | no |
| unhealthy\_host\_ratio\_transformation\_window | Transformation window for unhealthy\_host\_ratio detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| backend\_connect\_time\_id | id for detector backend\_connect\_time |
| backend\_http\_4xx\_errors\_id | id for detector backend\_http\_4xx\_errors |
| backend\_http\_5xx\_errors\_id | id for detector backend\_http\_5xx\_errors |
| failed\_requests\_id | id for detector failed\_requests |
| heartbeat\_id | id for detector heartbeat |
| http\_4xx\_errors\_id | id for detector http\_4xx\_errors |
| http\_5xx\_errors\_id | id for detector http\_5xx\_errors |
| total\_requests\_id | id for detector total\_requests |
| unhealthy\_host\_ratio\_id | id for detector unhealthy\_host\_ratio |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/azure-info.html)
[Azure monitor documenation](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported)
