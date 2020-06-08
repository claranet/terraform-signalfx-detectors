## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubernetes-apiserver.html)

## Requirements

You need to enable `persistentvolumes` and `persistentvolumeclaim` to cluster role of the SignalFx Agent.

Here is a Sample configuration for GKE:

```
    - type: kubernetes-apiserver
      host: metrics-server.kube-system
      port: 443
      useHTTPS: true
      skipVerify: true
      useServiceAccount: true
        extraMetrics:
          - apiserver_request_total
```

