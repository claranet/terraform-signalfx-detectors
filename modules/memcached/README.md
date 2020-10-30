# MIDDLEWARE MEMCACHED SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-middleware-memcached" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//modules/memcached?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}
```

In order to work properly, this module needs some [extraMetrics](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-memcached.html#non-default-metrics-version-4-7-0), the agent needs a least the following configuration for the [memcached](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-memcached.html) monitor :

```
monitors:
  - type: collectd/memcached
    host: 127.0.0.1
    port: &memcachedPort 11211
    extraDimensions:
      memcached_port: *memcachedPort
    extraMetrics:
      - total_events.listen_disabled
```

## Related documentation

* [Official documentation](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-memcached.html)
