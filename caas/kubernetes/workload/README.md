## Related documentation

The detectors in this module are based on metrics reported by the following monitors:
* [kubernetes-cluster](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubernetes-cluster.html)

## Requirements

Here is a sample configuration fragment for the SignalFx agent:

```
monitors:
- type: kubernetes-cluster
  extraMetrics:
    - kubernetes.job.active
```