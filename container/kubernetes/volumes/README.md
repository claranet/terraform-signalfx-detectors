## Related documentation

The detectors in this module are based on metrics reported by the following monitors:
* [kubernetes-volumes](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubernetes-volumes.html)

## Requirements

The following metrics must be emitted by the SignalFx agent:

- `kubernetes.volume_inodes`
- `kubernetes.volume_inodes_free`

Here is a sample configuration fragment for the SignalFx agent:

```
- type: kubernetes-volumes
  extraMetrics:
    - kubernetes.volume_inodes
    - kubernetes.volume_inodes_free
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

If you use the [Helm chart](https://github.com/signalfx/signalfx-agent/tree/master/deployments/k8s/helm/signalfx-agent) 
to deploy the agent, so you need chart version `>= 1.5.0` and enable `gatherVolumesMetrics: true` in `values.yml`.
