# MIDDLEWARE RABBITMQ Node SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-middleware-rabbitmq-node" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//middleware/rabbitmq/node?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}
```

In order to work properly, this module needs some [extraMetrics](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-rabbitmq.html#non-default-metrics-version-4-7-0), the agent needs a least the following configuration for the [collectd/rabbitmq](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-rabbitmq.html) monitor :

```yaml
monitors:
  - type: collectd/rabbitmq
    collectNodes: true
    collectQueues: true
    verbosityLevel: debug
    extraMetrics:
      - gauge.node.proc_used
      - gauge.node.proc_total
      - gauge.node.sockets_used
      - gauge.node.sockets_total
```

## Purpose

Creates SignalFx detectors with the following checks:

* RabbitMQ Node vm\_memory usage
* RabbitMQ Node sockets usage
* RabbitMQ Node file descriptors usage
* RabbitMQ Node process usage

In order to have a really complete monitoring, you should consider using the [queue module](../queue) as well.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| detectors\_disabled | Disable all detectors in this module | bool | `"false"` | no |
| environment | Infrastructure environment | string | n/a | yes |
| file\_descriptors\_aggregation\_function | Aggregation function and group by for file descriptors detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| file\_descriptors\_disabled | Disable all alerting rules for file descriptors detector | bool | `"null"` | no |
| file\_descriptors\_disabled\_critical | Disable critical alerting rule for file descriptors detector | bool | `"null"` | no |
| file\_descriptors\_disabled\_warning | Disable warning alerting rule for file descriptors detector | bool | `"null"` | no |
| file\_descriptors\_notifications | Notification recipients list for every alerting rules of file descriptors detector | list | `[]` | no |
| file\_descriptors\_notifications\_critical | Notification recipients list for critical alerting rule of file descriptors detector | list | `[]` | no |
| file\_descriptors\_notifications\_warning | Notification recipients list for warning alerting rule of file descriptors detector | list | `[]` | no |
| file\_descriptors\_threshold\_critical | Critical threshold for file descriptors detector | number | `"90"` | no |
| file\_descriptors\_threshold\_warning | Warning threshold for file descriptors detector | number | `"80"` | no |
| file\_descriptors\_transformation\_function | Transformation function for file descriptors detector (i.e. \".mean(over='5m')\")) | string | `"min"` | no |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | list | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | list | `[]` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | bool | `"null"` | no |
| heartbeat\_notifications | Notification recipients list for every alerting rules of heartbeat detector | list | `[]` | no |
| heartbeat\_timeframe | Timeframe for system not reporting detector \(i.e. "10m"\) | string | `"20m"` | no |
| notifications | Notification recipients list for every detectors | list | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | list | `[]` | no |
| processes\_aggregation\_function | Aggregation function and group by for processes detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| processes\_disabled | Disable all alerting rules for processes detector | bool | `"null"` | no |
| processes\_disabled\_critical | Disable critical alerting rule for processes detector | bool | `"null"` | no |
| processes\_disabled\_warning | Disable warning alerting rule for processes detector | bool | `"null"` | no |
| processes\_notifications | Notification recipients list for every alerting rules of processes detector | list | `[]` | no |
| processes\_notifications\_critical | Notification recipients list for critical alerting rule of processes detector | list | `[]` | no |
| processes\_notifications\_warning | Notification recipients list for warning alerting rule of processes detector | list | `[]` | no |
| processes\_threshold\_critical | Critical threshold for processes detector | number | `"90"` | no |
| processes\_threshold\_warning | Warning threshold for processes detector | number | `"80"` | no |
| processes\_transformation\_function | Transformation function for processes detector (i.e. \".mean(over='5m')\")) | string | `"min"` | no |
| sockets\_aggregation\_function | Aggregation function and group by for sockets detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| sockets\_disabled | Disable all alerting rules for sockets detector | bool | `"null"` | no |
| sockets\_disabled\_critical | Disable critical alerting rule for sockets detector | bool | `"null"` | no |
| sockets\_disabled\_warning | Disable warning alerting rule for sockets detector | bool | `"null"` | no |
| sockets\_notifications | Notification recipients list for every alerting rules of sockets detector | list | `[]` | no |
| sockets\_notifications\_critical | Notification recipients list for critical alerting rule of sockets detector | list | `[]` | no |
| sockets\_notifications\_warning | Notification recipients list for warning alerting rule of sockets detector | list | `[]` | no |
| sockets\_threshold\_critical | Critical threshold for sockets detector | number | `"90"` | no |
| sockets\_threshold\_warning | Warning threshold for sockets detector | number | `"80"` | no |
| sockets\_transformation\_function | Transformation function for sockets detector (i.e. \".mean(over='5m')\")) | string | `"min"` | no |
| vm\_memory\_aggregation\_function | Aggregation function and group by for vm\_memory detector \(i.e. ".mean\(by=\['host'\]\)."\) | string | `""` | no |
| vm\_memory\_disabled | Disable all alerting rules for vm\_memory detector | bool | `"null"` | no |
| vm\_memory\_disabled\_critical | Disable critical alerting rule for vm\_memory detector | bool | `"null"` | no |
| vm\_memory\_disabled\_warning | Disable warning alerting rule for vm\_memory detector | bool | `"null"` | no |
| vm\_memory\_notifications | Notification recipients list for every alerting rules of vm\_memory detector | list | `[]` | no |
| vm\_memory\_notifications\_critical | Notification recipients list for critical alerting rule of vm\_memory detector | list | `[]` | no |
| vm\_memory\_notifications\_warning | Notification recipients list for warning alerting rule of vm\_memory detector | list | `[]` | no |
| vm\_memory\_threshold\_critical | Critical threshold for vm\_memory detector | number | `"90"` | no |
| vm\_memory\_threshold\_warning | Warning threshold for vm\_memory detector | number | `"80"` | no |
| vm\_memory\_transformation\_function | Transformation function for vm\_memory detector (i.e. \".mean(over='5m')\")) | string | `"min"` | no |

## Outputs

| Name | Description |
|------|-------------|
| file\_descriptors\_id | id for detector file descriptors |
| heartbeat\_id | id for detector heartbeat |
| processes\_id | id for detector processes |
| sockets\_id | id for detector sockets |
| vm\_memory\_id | id for detector vm memory |

## Related documentation

[Official documentation for RabbitMQ](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-rabbitmq.html)
