# MIDDLEWARE JMX SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-middleware-jmx" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//middleware/jmx?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}
```

## Purpose

Creates SignalFx detectors with the following checks:
- JMX GC old generation usage	
- JMX memory heap usage	

## Notes

This module uses the [GenericJMX](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-genericjmx.html)
monitor to fetch common Java runtime metrics for every JVM based applications.

You must [enable JMX Remote](https://docs.oracle.com/javadb/10.10.1.2/adminguide/radminjmxenabledisable.html) on your JAVA
application. Depending on your application you should add following paramters as example:

```
-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=5000 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=127.0.0.1
```

If there is a native GenericJMX based monitor for your specific application like for
[Cassandra](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-cassandra.html)
so you should configure its dedicated monitor and you will automatically retrieve required metrics for this module.

Else if there is no monitor available for your specific application or you simply do not want to collect specific
application metrics, so you have to configure the GenericJMX directly:

```
-   type: collectd/genericjmx
    host: 127.0.0.1
    port: 5000
```

Keep in mind you can easily add specific application metrics defining `mBeanDefinitions` parameter.
