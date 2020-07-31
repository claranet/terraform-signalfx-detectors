## Related documentation

Here is the [official documentation](https://docs.signalfx.com/en/latest/integrations/kubernetes/k8s-quick-install.html) 
to install the signalfx-agent on kubernetes.

The detectors in this module are based on metrics reported by the following monitors:
* [kubelet-stats](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubelet-stats.html)
* [kubernetes-cluster](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubernetes-cluster.html)

## Requirements

The following metrics must be emitted by the SignalFx agent:

- `kubernetes.job.failed`
- `kubernetes.stateful_set.ready`
- `kubernetes.stateful_set.desired`

## Agent configuration

Here is a sample configuration fragment for the SignalFx agent for GKE:

```yaml
monitors:
- type: kubelet-stats
  kubeletAPI:
    authType: serviceAccount
  datapointsToExclude:
  - dimensions:
      container_image:
      - '*pause-amd64*'
      - 'k8s.gcr.io/pause*'
    metricNames:
      - '*'
      - '!*network*'

- type: kubernetes-cluster
  extraMetrics:
    - kubernetes.job.failed
    - kubernetes.stateful_set.ready
    - kubernetes.stateful_set.desired
```

Using the SignalFx [Helm](https://helm.sh/) [chart](https://github.com/signalfx/signalfx-agent/tree/master/deployments/k8s/helm/signalfx-agent)
could ease the agent installation and configuration:

```yaml

# Increase depending on your use case
resources:
  limits:
    cpu: 250m
    memory: 768Mi
  requests:
    cpu: 100m
    memory: 128Mi

# Change for your kubernetes cluster name
clusterName: "sfx-doc"

# Change for your realm
signalFxRealm: eu0

# Required to use the default filtering convention
globalDimensions:
  sfx_monitored: true
  # Change for your env
  env: sandbox

# Required to use this module
clusterExtraMetrics:
  - kubernetes.job.failed
  - kubernetes.stateful_set.ready
  - kubernetes.stateful_set.desired

# Required to use "system-generic" module
loadPerCPU: true

# Required to use "kubernetes-volumes" module
gatherVolumesMetrics: true

# Required to use "kubernetes-ingress-nginx" module
monitors:
  - type: prometheus-exporter
    discoveryRule: container_image =~ "nginx-ingress-controller" && port == 10254
    port: 10254
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!nginx_ingress_controller_requests'
        - '!nginx_ingress_controller_ingress_upstream_latency_seconds'
```

## Notes

### About `node_ready` detector

- it works as for most of the "heartbeat" detectors in this repo; using state property from cloud provider to ignore alerts on host which has been terminated / stopped (i.e. autoscaling group)
- the goal is to avoid any alert considered as normal because of host has been removed (automatically or manually)
- but the detector will always raise alert for environment outside the cloud while we do any way to know if "not ready node" comes from stopped / terminated host or a real problem.

### About `job_failed` detector

- it works only on job running from cronjob
- this will obviously raise an alert when a job is considered as failed from kubernetes point of view. Indeed, some pods could eventually fail or retry without to mark the job as failed
- but the alert will remain until you clean/purge jobs history. Indeed, even if a new, more recent, successful job has been running in the meantime the alert will continue until you delete the failed job
