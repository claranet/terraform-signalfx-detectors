# CLOUD AZURE Storage account capacity SignalFx detectors

Detectors to apply for Azure storage account if you need to setup quotas over storages.

## How to use this module

```hcl
module "signalfx-detectors-cloud-azure-storage-account-capacity" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//cloud/azure/storage-account-capacity?ref={revision}"

  environment   = var.environment
  notifications = local.notifications

  used_capacity_threshold_major    = 90  # 90GB
  used_capacity_threshold_critical = 100 # 100GB
}
```

## Purpose

Creates SignalFx detectors with the following checks:

* Azure Storage Account used capacity

## Providers

| Name | Version |
|------|---------|
| signalfx | >= 4.26.4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| environment | Infrastructure environment | `string` | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | `list` | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | `list` | `[]` | no |
| notifications | Default notification recipients list per severity | <pre>object({<br>    critical = list(string)<br>    major    = list(string)<br>    minor    = list(string)<br>    warning  = list(string)<br>    info     = list(string)<br>  })</pre> | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |
| used\_capacity\_aggregation\_function | Aggregation function and group by for used\_capacity detector (i.e. ".mean(by=['host'])") | `string` | `".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"` | no |
| used\_capacity\_disabled | Disable all alerting rules for used\_capacity detector | `bool` | `null` | no |
| used\_capacity\_disabled\_critical | Disable critical alerting rule for used\_capacity detector | `bool` | `null` | no |
| used\_capacity\_disabled\_major | Disable major alerting rule for used\_capacity detector | `bool` | `null` | no |
| used\_capacity\_notifications | Notification recipients list per severity overridden for used\_capacity detector | `map(list(string))` | `{}` | no |
| used\_capacity\_threshold\_critical | Critical threshold for used\_capacity detector (in GB) | `number` | n/a | yes |
| used\_capacity\_threshold\_major | Major threshold for used\_capacity detector (in GB) | `number` | n/a | yes |
| used\_capacity\_transformation\_function | Transformation function for used\_capacity detector (i.e. ".mean(over='5m')") | `string` | `".max(over='12h')"` | no |

## Outputs

| Name | Description |
|------|-------------|
| used\_capacity | Detector resource for used\_capacity |
