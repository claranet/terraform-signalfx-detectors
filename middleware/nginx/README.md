# MIDDLEWARE NGINX SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-middleware-nginx" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//middleware/nginx?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

```

## Purpose

Creates SignalFx detectors with the following checks:

- Nginx dropped connections
- Nginx heartbeat

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| dropped\_connections\_aggregation\_function | Aggregation function and group by for dropped connections detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| dropped\_connections\_disabled | Disable all alerting rules for dropped connections detector | `bool` | n/a | yes |
| dropped\_connections\_disabled\_critical | Disable critical alerting rule for dropped connections detector | `bool` | n/a | yes |
| dropped\_connections\_disabled\_warning | Disable warning alerting rule for dropped connections detector | `bool` | n/a | yes |
| dropped\_connections\_notifications | Notification recipients list for every alerting rules of dropped connections detector | `list` | `[]` | no |
| dropped\_connections\_notifications\_critical | Notification recipients list for critical alerting rule of dropped connections detector | `list` | `[]` | no |
| dropped\_connections\_notifications\_warning | Notification recipients list for warning alerting rule of dropped connections detector | `list` | `[]` | no |
| dropped\_connections\_threshold\_critical | Critical threshold for dropped connections detector | `number` | `1` | no |
| dropped\_connections\_threshold\_warning | Warning threshold for dropped connections detector | `number` | `0` | no |
| dropped\_connections\_transformation\_function | Transformation function for dropped connections detector (mean, min, max) | `string` | `"min"` | no |
| dropped\_connections\_transformation\_window | Transformation window for dropped connections detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| environment | Infrastructure environment | `string` | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | `list` | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | `list` | `[]` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | `bool` | n/a | yes |
| heartbeat\_notifications | Notification recipients list for every alerting rules of heartbeat detector | `list` | `[]` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector (i.e. "10m") | `string` | `"20m"` | no |
| notifications | Notification recipients list for every detectors | `list` | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| dropped\_connections\_id | id for detector dropped\_connections |
| heartbeat\_id | id for detector heartbeat |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.nginx.html)
