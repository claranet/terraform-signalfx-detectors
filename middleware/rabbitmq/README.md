# MIDDLEWARE RABBITMQ SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-middleware-rabbitmq" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//middleware/rabbitmq?ref={revision}"

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
      - gauge.node.proc_used
      - gauge.node.proc_total
      - gauge.node.sockets_used
      - gauge.node.sockets_total
      - gauge.queue.messages_unacknowledged
      - counter.queue.message_stats.ack
      - gauge.queue.consumer_utilisation
```

## Purpose

Creates SignalFx detectors with the following checks:

* RabbitMQ Node vm\_memory usage
* RabbitMQ Node sockets usage
* RabbitMQ Node file descriptors usage
* RabbitMQ Node process usage
* RabbitMQ Queue messages ready
* RabbitMQ Queue messages unacknowledged (disabled by default)
* RabbitMQ Queue messages ack rate (disable by default)
* RabbitMQ Queue consumer utilisation (disable by default)

The default alerting  behavior is to alert when the number of ready message in any queue will be above `messages_ready_thresholds`.  It is possible to create multiple detectors with specific filters if you need different thresholds.

This can also be done with the `messages_unacknowledged`, `messages_ack_rate` and `consumer_utilisation` detectors which are disabled by default.

Example : 

```hcl
module "signalfx-detectors-aws-beanstalk-rabbitmq" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//middleware/rabbitmq?ref={revision}"

  environment   = var.environment
  
  messages_ready_thresholds = {
    "my-queue-1" = {
        filter = "filter('name', 'my-queue-1') and filter('vhost', '/my-vhost')"
        threshold_critical = 300
        threshold_warning  = 200
    }
    "my-queue-2" = {
        filter = "filter('name', 'my-queue-2')"
        threshold_critical = 20
        threshold_warning  = 10
    }
  }

  messages_ack_rate_disabled   = false
  messages_ack_rate_thresholds = {
    "my-queue-3" = {
        filter = "filter('name', 'my-queue-3')"
        threshold_critical = 2
        threshold_warning  = 3
    }
  }
  notifications = var.notifications 
}
````

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| consumer\_utilisation\_aggregation\_function | Aggregation function and group by for consumer\_utilisation detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| consumer\_utilisation\_disabled | Disable all alerting rules for consumer\_utilisation detector | bool | `true` | no |
| consumer\_utilisation\_disabled\_critical | Disable critical alerting rule for consumer\_utilisation detector | bool | `null` | no |
| consumer\_utilisation\_disabled\_warning | Disable warning alerting rule for consumer\_utilisation detector | bool | `null` | no |
| consumer\_utilisation\_duration | Duration for consumer\_utilisation detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"10m"` | no |
| consumer\_utilisation\_notifications | Notification recipients list for every alerting rules of consumer\_utilisation detector | list | `[]` | no |
| consumer\_utilisation\_notifications\_critical | Notification recipients list for critical alerting rule of consumer\_utilisation detector | list | `[]` | no |
| consumer\_utilisation\_notifications\_warning | Notification recipients list for warning alerting rule of consumer\_utilisation detector | list | `[]` | no |
| consumer\_utilisation\_thresholds | Thresholds value for consumer\_utilisation detector. Several filters can be associated to different thresholds. The filter field must be in the SignalFx filter format. | map | `{ "default": [ { "filter": "filter('name', '*')", "threshold_critical": 0.8, "threshold_warning": 1 } ] }` | no |
| detectors\_disabled | Disable all detectors in this module | bool | `false` | no |
| environment | Infrastructure environment | string | n/a | yes |
| file\_descriptors\_aggregation\_function | Aggregation function and group by for file descriptors detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| file\_descriptors\_disabled | Disable all alerting rules for file descriptors detector | bool | `null` | no |
| file\_descriptors\_disabled\_critical | Disable critical alerting rule for file descriptors detector | bool | `null` | no |
| file\_descriptors\_disabled\_warning | Disable warning alerting rule for file descriptors detector | bool | `null` | no |
| file\_descriptors\_notifications | Notification recipients list for every alerting rules of file descriptors detector | list | `[]` | no |
| file\_descriptors\_notifications\_critical | Notification recipients list for critical alerting rule of file descriptors detector | list | `[]` | no |
| file\_descriptors\_notifications\_warning | Notification recipients list for warning alerting rule of file descriptors detector | list | `[]` | no |
| file\_descriptors\_threshold\_critical | Critical threshold for file descriptors detector | number | `90` | no |
| file\_descriptors\_threshold\_warning | Warning threshold for file descriptors detector | number | `80` | no |
| file\_descriptors\_transformation\_function | Transformation function for file descriptors detector \(mean, min, max\) | string | `"min"` | no |
| file\_descriptors\_transformation\_window | Transformation window for file descriptors detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"10m"` | no |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | list | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | list | `[]` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | bool | `null` | no |
| heartbeat\_notifications | Notification recipients list for every alerting rules of heartbeat detector | list | `[]` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector \(i.e. "10m"\) | string | `"20m"` | no |
| messages\_ack\_rate\_aggregation\_function | Aggregation function and group by for messages\_ack\_rate detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| messages\_ack\_rate\_disabled | Disable all alerting rules for messages\_ack\_rate detector | bool | `true` | no |
| messages\_ack\_rate\_disabled\_critical | Disable critical alerting rule for messages\_ack\_rate detector | bool | `null` | no |
| messages\_ack\_rate\_disabled\_warning | Disable warning alerting rule for messages\_ack\_rate detector | bool | `null` | no |
| messages\_ack\_rate\_duration | Duration for messages\_ack\_rate detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"10m"` | no |
| messages\_ack\_rate\_notifications | Notification recipients list for every alerting rules of messages\_ack\_rate detector | list | `[]` | no |
| messages\_ack\_rate\_notifications\_critical | Notification recipients list for critical alerting rule of messages\_ack\_rate detector | list | `[]` | no |
| messages\_ack\_rate\_notifications\_warning | Notification recipients list for warning alerting rule of messages\_ack\_rate detector | list | `[]` | no |
| messages\_ack\_rate\_thresholds | Thresholds value for messages ack rate detector. Several filters can be associated to different thresholds. The filter field must be in the SignalFx filter format. | map | `{}` | no |
| messages\_ready\_aggregation\_function | Aggregation function and group by for messages\_ready detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| messages\_ready\_disabled | Disable all alerting rules for messages\_ready detector | bool | `null` | no |
| messages\_ready\_disabled\_critical | Disable critical alerting rule for messages\_ready detector | bool | `null` | no |
| messages\_ready\_disabled\_warning | Disable warning alerting rule for messages\_ready detector | bool | `null` | no |
| messages\_ready\_notifications | Notification recipients list for every alerting rules of messages\_ready detector | list | `[]` | no |
| messages\_ready\_notifications\_critical | Notification recipients list for critical alerting rule of messages\_ready detector | list | `[]` | no |
| messages\_ready\_notifications\_warning | Notification recipients list for warning alerting rule of messages\_ready detector | list | `[]` | no |
| messages\_ready\_thresholds | Thresholds value for messages ready detector. Several filters can be associated to different thresholds. The filter field must be in the SignalFx filter format. | map | `{ "default": [ { "filter": "filter('name', '*')", "threshold_critical": "10000", "threshold_warning": "15000" } ] }` | no |
| messages\_ready\_transformation\_function | Transformation function for messages\_ready detector \(mean, min, max\) | string | `"min"` | no |
| messages\_ready\_transformation\_window | Transformation window for messages\_ready detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"20m"` | no |
| messages\_unacknowledged\_aggregation\_function | Aggregation function and group by for messages\_unacknowledged detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| messages\_unacknowledged\_disabled | Disable all alerting rules for messages\_unacknowledged detector | bool | `true` | no |
| messages\_unacknowledged\_disabled\_critical | Disable critical alerting rule for messages\_unacknowledged detector | bool | `null` | no |
| messages\_unacknowledged\_disabled\_warning | Disable warning alerting rule for messages\_unacknowledged detector | bool | `null` | no |
| messages\_unacknowledged\_notifications | Notification recipients list for every alerting rules of messages\_unacknowledged detector | list | `[]` | no |
| messages\_unacknowledged\_notifications\_critical | Notification recipients list for critical alerting rule of messages\_unacknowledged detector | list | `[]` | no |
| messages\_unacknowledged\_notifications\_warning | Notification recipients list for warning alerting rule of messages\_unacknowledged detector | list | `[]` | no |
| messages\_unacknowledged\_thresholds | Thresholds value for messages unacknowledged detector. Several filters can be associated to different thresholds. The filter field must be in the SignalFx filter format. | map | `{ "default": [ { "filter": "filter('name', '*')", "threshold_critical": "10000", "threshold_warning": "15000" } ] }` | no |
| messages\_unacknowledged\_transformation\_function | Transformation function for messages\_unacknowledged detector \(mean, min, max\) | string | `"min"` | no |
| messages\_unacknowledged\_transformation\_window | Transformation window for messages\_unacknowledged detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"20m"` | no |
| notifications | Notification recipients list for every detectors | list | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | list | `[]` | no |
| processes\_aggregation\_function | Aggregation function and group by for processes detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| processes\_disabled | Disable all alerting rules for processes detector | bool | `null` | no |
| processes\_disabled\_critical | Disable critical alerting rule for processes detector | bool | `null` | no |
| processes\_disabled\_warning | Disable warning alerting rule for processes detector | bool | `null` | no |
| processes\_notifications | Notification recipients list for every alerting rules of processes detector | list | `[]` | no |
| processes\_notifications\_critical | Notification recipients list for critical alerting rule of processes detector | list | `[]` | no |
| processes\_notifications\_warning | Notification recipients list for warning alerting rule of processes detector | list | `[]` | no |
| processes\_threshold\_critical | Critical threshold for processes detector | number | `90` | no |
| processes\_threshold\_warning | Warning threshold for processes detector | number | `80` | no |
| processes\_transformation\_function | Transformation function for processes detector \(mean, min, max\) | string | `"min"` | no |
| processes\_transformation\_window | Transformation window for processes detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"10m"` | no |
| sockets\_aggregation\_function | Aggregation function and group by for sockets detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| sockets\_disabled | Disable all alerting rules for sockets detector | bool | `null` | no |
| sockets\_disabled\_critical | Disable critical alerting rule for sockets detector | bool | `null` | no |
| sockets\_disabled\_warning | Disable warning alerting rule for sockets detector | bool | `null` | no |
| sockets\_notifications | Notification recipients list for every alerting rules of sockets detector | list | `[]` | no |
| sockets\_notifications\_critical | Notification recipients list for critical alerting rule of sockets detector | list | `[]` | no |
| sockets\_notifications\_warning | Notification recipients list for warning alerting rule of sockets detector | list | `[]` | no |
| sockets\_threshold\_critical | Critical threshold for sockets detector | number | `90` | no |
| sockets\_threshold\_warning | Warning threshold for sockets detector | number | `80` | no |
| sockets\_transformation\_function | Transformation function for sockets detector \(mean, min, max\) | string | `"min"` | no |
| sockets\_transformation\_window | Transformation window for sockets detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"10m"` | no |
| vm\_memory\_aggregation\_function | Aggregation function and group by for vm\_memory detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| vm\_memory\_disabled | Disable all alerting rules for vm\_memory detector | bool | `null` | no |
| vm\_memory\_disabled\_critical | Disable critical alerting rule for vm\_memory detector | bool | `null` | no |
| vm\_memory\_disabled\_warning | Disable warning alerting rule for vm\_memory detector | bool | `null` | no |
| vm\_memory\_notifications | Notification recipients list for every alerting rules of vm\_memory detector | list | `[]` | no |
| vm\_memory\_notifications\_critical | Notification recipients list for critical alerting rule of vm\_memory detector | list | `[]` | no |
| vm\_memory\_notifications\_warning | Notification recipients list for warning alerting rule of vm\_memory detector | list | `[]` | no |
| vm\_memory\_threshold\_critical | Critical threshold for vm\_memory detector | number | `90` | no |
| vm\_memory\_threshold\_warning | Warning threshold for vm\_memory detector | number | `80` | no |
| vm\_memory\_transformation\_function | Transformation function for vm\_memory detector \(mean, min, max\) | string | `"min"` | no |
| vm\_memory\_transformation\_window | Transformation window for vm\_memory detector \(i.e. 5m, 20m, 1h, 1d\) | string | `"10m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| consumer\_utilisation\_ids | id for detector consumer\_utilisation |
| file\_descriptors\_id | id for detector file descriptors |
| heartbeat\_id | id for detector heartbeat |
| messages\_ack\_rate\_ids | id for detector messages\_ack\_rate |
| messages\_ready\_ids | id for detector messages\_ready\_ids |
| messages\_unacknowledged\_ids | id for detector messages\_unacknowledged\_ids |
| processes\_id | id for detector processes |
| sockets\_id | id for detector sockets |
| vm\_memory\_id | id for detector vm memory |

## Related documentation

[Official documentation for RabbitMQ](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-rabbitmq.html)
