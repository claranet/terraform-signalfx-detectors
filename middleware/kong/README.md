# MIDDLEWARE KONG SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-middleware-kong" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//middleware/kong?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

```

## Purpose

Creates SignalFx detectors with the following checks:

- Kong heartbeat
- Kong treatment limit

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| environment | Infrastructure environment | `string` | n/a | yes |
| filter\_custom\_excludes | Tags to exclude when using custom filtering (i.e "tag1:val1;tag2:val2") | `string` | `""` | no |
| filter\_custom\_includes | Tags to filter signals on when custom filtering is used (i.e "tag1:val1;tag2:val2") | `string` | `""` | no |
| filter\_use\_defaults | Use default filtering which follows tagging convention | `bool` | `true` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | `bool` | n/a | yes |
| heartbeat\_notifications | Notification recipients list for every alerting rules of heartbeat detector | `list` | `[]` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector (i.e. "10m") | `string` | `"20m"` | no |
| notifications | Notification recipients list (i.e. "Email,my@mail.com;PagerDuty,credentialId") | `list` | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |
| treatment\_limit\_aggregation\_function | Aggregation function and group by for treatment limit detector (i.e. ".mean(by=['host']).") | `string` | `""` | no |
| treatment\_limit\_disabled | Disable all alerting rules for treatment limit detector | `bool` | n/a | yes |
| treatment\_limit\_disabled\_critical | Disable critical alerting rule for treatment limit detector | `bool` | n/a | yes |
| treatment\_limit\_disabled\_warning | Disable warning alerting rule for treatment limit detector | `bool` | n/a | yes |
| treatment\_limit\_notifications | Notification recipients list for every alerting rules of treatment limit detector | `list` | `[]` | no |
| treatment\_limit\_notifications\_critical | Notification recipients list for critical alerting rule of treatment limit detector | `list` | `[]` | no |
| treatment\_limit\_notifications\_warning | Notification recipients list for warning alerting rule of treatment limit detector | `list` | `[]` | no |
| treatment\_limit\_threshold\_critical | Critical threshold for treatment limit detector | `number` | `20` | no |
| treatment\_limit\_threshold\_warning | Warning threshold for treatment limit detector | `number` | `0` | no |
| treatment\_limit\_transformation\_function | Transformation function for treatment limit detector (mean, min, max) | `string` | `"min"` | no |
| treatment\_limit\_transformation\_window | Transformation window for treatment limit detector (i.e. 5m, 20m, 1h, 1d) | `string` | `"15m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| heartbeat\_id | id for detector heartbeat |
| treatment\_limit\_id | id for detector treatment limit |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.kong.html)
