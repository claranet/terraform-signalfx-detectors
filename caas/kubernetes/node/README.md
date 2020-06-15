## Related documentation

The detectors in this module are based on metrics reported by the following monitors:
* [kubelet-stats](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubelet-stats.html)
* [kubernetes-cluster](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubernetes-cluster.html)
* [kubernetes-volumes](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubernetes-volumes.html)

## Requirements

Here is a sample configuration fragment for the SignalFx agent:

```
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
    - kubernetes.job.active
    - kubernetes.job.failed

- type: kubernetes-volumes
```

In addition to the base permissions granted to the cluster role associated to the SignalFx Agent's service account in the official Helm Chart,
it must also have the `get`, `list` and `watch` on `persistentvolumes` and `persistentvolumeclaim` resources.

Here is a configuration fragment for the SignalFx agent's cluster role:

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app: signalfx-agent
  name: signalfx-agent
rules:
- apiGroups:
  - ""
  resources:
  - persistentvolumes
  - persistentvolumeclaims
  verbs:
  - get
  - list
  - watch
...
```
