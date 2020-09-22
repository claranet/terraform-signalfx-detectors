# MIDDLEWARE Java SignalFx detectors

## Prerequisites

In the **bin/setenv.sh** file:
```
-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=5000 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=127.0.0.1
```

In the **/etc/signalfx/agent.yaml**:

```
-   type: collectd/genericjmx
    host: 127.0.0.1
    port: 5000
```

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
- JMX G1 Old Gen Space Usage	
- JMX Memory CodeCache Space Usage	
- JMX Memory Compressed Class Space Usage	
- JMX Memory Geometry Metaspace Space Usage	
- JMX Memory Heap Usage	
- JMX Memory Non Heap Usage	
- JMX Memory Survivor Space Usage	
- JMX Threads Count
