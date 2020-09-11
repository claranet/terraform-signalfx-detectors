## Related documentation

The detectors in this module are based on metrics reported by the following monitors:
* [kubernetes-apiserver](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubernetes-apiserver.html)

## Requirements

The following metrics must be emitted by the SignalFx agent:

- `apiserver_request_total`

Here is a sample configuration fragment for the SignalFx agent:

```
monitors:
- type: kubernetes-apiserver
  host: metrics-server.kube-system
  port: 443
  useHTTPS: true
  skipVerify: true
  useServiceAccount: true
    extraMetrics:
      - apiserver_request_total
```
