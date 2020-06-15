# MIDDLEWARE RABBITMQ QUEUE SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-middleware-rabbitmq-queue" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//middleware/rabbitmq/queue?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

In order to work properly, this module needs some [extraMetrics](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-rabbitmq.html#non-default-metrics-version-4-7-0), the agent needs a least the following configuration for the [collectd/rabbitmq](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-rabbitmq.html) monitor :

```yaml
monitors:
  - type: collectd/rabbitmq
    collectNodes: true
    collectQueues: true
    verbosityLevel: true
    extraMetrics:
      - gauge.queue.messages_unacknowledged
      - counter.queue.message_stats.ack
      - gauge.queue.consumer_utilisation
```

## Purpose

Creates SignalFx detectors with the following checks:

* RabbitMQ Queue messages ready
* RabbitMQ Queue messages unacknowledged (disabled by default)
* RabbitMQ Queue messages ack rate (disable by default)
* RabbitMQ Queue consumer utilisation (disable by default)

The default behavior is to alert when the number of ready message in any queue will be above `messages_ready_thresholds`. Please enable the other detectors and configure thresholds according to your needs and use cases. Call this module several times with different filters to speficy custom thresholds (on a particular queue for example). 

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| consumer\_utilisation\_aggregation\_function | Aggregation function and group by for consumer\_utilisation detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| consumer\_utilisation\_disabled | Disable all alerting rules for consumer\_utilisation detector | bool | `"true"` | no |
| consumer\_utilisation\_disabled\_critical | Disable critical alerting rule for consumer\_utilisation detector | bool | `"null"` | no |
| consumer\_utilisation\_disabled\_warning | Disable warning alerting rule for consumer\_utilisation detector | bool | `"null"` | no |
| consumer\_utilisation\_duration | Duration for consumer\_utilisation detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"10m"` | no |
| consumer\_utilisation\_notifications | Notification recipients list for every alerting rules of consumer\_utilisation detector | list | `[]` | no |
| consumer\_utilisation\_notifications\_critical | Notification recipients list for critical alerting rule of consumer\_utilisation detector | list | `[]` | no |
| consumer\_utilisation\_notifications\_warning | Notification recipients list for warning alerting rule of consumer\_utilisation detector | list | `[]` | no |
| consumer\_utilisation\_threshold\_critical | Critical threshold for consumer utilisation detector. | string | `"0.8"` | no |
| consumer\_utilisation\_threshold\_warning | Warning threshold for consumer utilisation detector. | number | `"1.0"` | no |
| detectors\_disabled | Disable all detectors in this module | bool | `"false"` | no |
| environment | Infrastructure environment | string | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | list | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | list | `[]` | no |
| messages\_ack\_rate\_aggregation\_function | Aggregation function and group by for messages\_ack\_rate detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| messages\_ack\_rate\_disabled | Disable all alerting rules for messages\_ack\_rate detector | bool | `"true"` | no |
| messages\_ack\_rate\_disabled\_critical | Disable critical alerting rule for messages\_ack\_rate detector | bool | `"null"` | no |
| messages\_ack\_rate\_disabled\_warning | Disable warning alerting rule for messages\_ack\_rate detector | bool | `"null"` | no |
| messages\_ack\_rate\_duration | Duration for messages\_ack\_rate detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"10m"` | no |
| messages\_ack\_rate\_notifications | Notification recipients list for every alerting rules of messages\_ack\_rate detector | list | `[]` | no |
| messages\_ack\_rate\_notifications\_critical | Notification recipients list for critical alerting rule of messages\_ack\_rate detector | list | `[]` | no |
| messages\_ack\_rate\_notifications\_warning | Notification recipients list for warning alerting rule of messages\_ack\_rate detector | list | `[]` | no |
| messages\_ack\_rate\_threshold\_critical | Critical threshold for messages ack rate detector. Specify it as a string with a rate, 2/60 means 2 ack per minute. | string | `"1/60"` | no |
| messages\_ack\_rate\_threshold\_warning | Warning threshold for messages ack rate detector. Specify it as a string with a rate, 2/60 means 2 ack per minute. | string | `"2/60"` | no |
| messages\_ready\_aggregation\_function | Aggregation function and group by for messages\_ready detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| messages\_ready\_disabled | Disable all alerting rules for messages\_ready detector | bool | `"null"` | no |
| messages\_ready\_disabled\_critical | Disable critical alerting rule for messages\_ready detector | bool | `"null"` | no |
| messages\_ready\_disabled\_warning | Disable warning alerting rule for messages\_ready detector | bool | `"null"` | no |
| messages\_ready\_notifications | Notification recipients list for every alerting rules of messages\_ready detector | list | `[]` | no |
| messages\_ready\_notifications\_critical | Notification recipients list for critical alerting rule of messages\_ready detector | list | `[]` | no |
| messages\_ready\_notifications\_warning | Notification recipients list for warning alerting rule of messages\_ready detector | list | `[]` | no |
| messages\_ready\_threshold\_critical | Critical threshold for messages ready detector. | number | `"15000"` | no |
| messages\_ready\_threshold\_warning | Warning threshold for messages ready detector. | number | `"10000"` | no |
| messages\_ready\_transformation\_function | Transformation function for messages\_ready detector \(mean, min, max\) | string | `"min"` | no |
| messages\_ready\_transformation\_window | Transformation window for messages\_ready detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"20m"` | no |
| messages\_unacknowledged\_aggregation\_function | Aggregation function and group by for messages\_unacknowledged detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| messages\_unacknowledged\_disabled | Disable all alerting rules for messages\_unacknowledged detector | bool | `"true"` | no |
| messages\_unacknowledged\_disabled\_critical | Disable critical alerting rule for messages\_unacknowledged detector | bool | `"null"` | no |
| messages\_unacknowledged\_disabled\_warning | Disable warning alerting rule for messages\_unacknowledged detector | bool | `"null"` | no |
| messages\_unacknowledged\_notifications | Notification recipients list for every alerting rules of messages\_unacknowledged detector | list | `[]` | no |
| messages\_unacknowledged\_notifications\_critical | Notification recipients list for critical alerting rule of messages\_unacknowledged detector | list | `[]` | no |
| messages\_unacknowledged\_notifications\_warning | Notification recipients list for warning alerting rule of messages\_unacknowledged detector | list | `[]` | no |
| messages\_unacknowledged\_threshold\_critical | Critical threshold for messages unacknowledged detector. | number | `"15000"` | no |
| messages\_unacknowledged\_threshold\_warning | Warning threshold for messages unacknowledged detector. | number | `"10000"` | no |
| messages\_unacknowledged\_transformation\_function | Transformation function for messages\_unacknowledged detector \(mean, min, max\) | string | `"min"` | no |
| messages\_unacknowledged\_transformation\_window | Transformation window for messages\_unacknowledged detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"20m"` | no |
| notifications | Notification recipients list for every detectors | list | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | list | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| consumer\_utilisation\_ids | id for detector consumer\_utilisation |
| messages\_ack\_rate\_ids | id for detector messages\_ack\_rate |
| messages\_ready\_ids | id for detector messages\_ready\_ids |
| messages\_unacknowledged\_ids | id for detector messages\_unacknowledged\_ids |

## Related documentation

[Official documentation for RabbitMQ](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-rabbitmq.html)
