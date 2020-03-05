# MIDDLEWARE NGINX SignalFX detectors

## How to use this module

```hcl
module "signalfx-detectors-middleware-nginx" {
  source      = "git::ssh://git@github.com/claranet/terraform-signalfx-detectors.git//middleware/nginx?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

```

## Purpose

Creates SignalFX detectors with the following checks:

- Nginx dropped connections
- Nginx heartbeat

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| dropped\_connections\_aggregation\_function | Aggregation function and group by for dropped connections detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| dropped\_connections\_critical\_disabled | Disable critical alerting rule for dropped connections detector | `bool` | `false` | no |
| dropped\_connections\_critical\_notifications | Notification recipients semicolon for critical alerting rule of dropped connections detector | `string` | `""` | no |
| dropped\_connections\_disabled | Disable all alerting rules for dropped connections detector | `bool` | `false` | no |
| dropped\_connections\_notifications | Notification recipients semicolon for every alerting rules of dropped connections detector | `string` | `""` | no |
| dropped\_connections\_threshold\_critical | Critical threshold for dropped connections detector | `number` | `1` | no |
| dropped\_connections\_threshold\_warning | Warning threshold for dropped connections detector | `number` | `0` | no |
| dropped\_connections\_transformation\_function | Transformation function for dropped connections detector (mean, min, max) | `string` | `"min"` | no |
| dropped\_connections\_transformation\_window | Transformation window for dropped connections detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"5m"` | no |
| dropped\_connections\_warning\_disabled | Disable warning alerting rule for dropped connections detector | `bool` | `false` | no |
| dropped\_connections\_warning\_notifications | Notification recipients semicolon for warning alerting rule of dropped connections detector | `string` | `""` | no |
| environment | Architecture Environment | `string` | n/a | yes |
| filter\_custom\_excludes | Tags to exclude when using custom filtering (i.e "tag1:val1;tag2:val2") | `string` | `""` | no |
| filter\_custom\_includes | Tags to filter signals on when custom filtering is used (i.e "tag1:val1;tag2:val2") | `string` | `""` | no |
| filter\_use\_defaults | Use default filtering which follows tagging convention | `bool` | `true` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | `bool` | `false` | no |
| heartbeat\_notifications | Notification recipients semicolon for every alerting rules of heartbeat detector | `string` | `""` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector (i.e. "10m") | `string` | `"20m"` | no |
| notifications | Notification recipients semicolon separated (i.e. "Email,my@mail.com;PagerDuty,credentialId") | `string` | n/a | yes |
| prefixes\_slug | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| dropped\_connections\_id | id for detector dropped\_connections |
| heartbeat\_id | id for detector heartbeat |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.nginx.html)
