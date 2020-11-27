# COMMON SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Agent](#agent)
  - [Monitors](#monitors)
  - [Examples](#examples)
- [Notes](#notes)
  - [About `node_ready` detector](#about-node_ready-detector)
  - [About `job_failed` detector](#about-job_failed-detector)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a 
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-container-kubernetes-common" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//container/kubernetes/common?ref={revision}"

  environment   = var.environment
  notifications = local.notifications
}
```

Note the following parameters:

* `source`: Use this parameter to specify the URL of the module. The double slash (`//`) is intentional  and required. 
  Terraform uses it to specify subfolders within a Git repo (see [module
  sources](https://www.terraform.io/docs/modules/sources.html)). The `ref` parameter specifies a specific Git tag in
  this repository. It is recommended to use the latest "pinned" version in place of `{revision}`. Avoid using a branch 
  like `master` except for testing purpose. Note that every modules in this repository are available on the Terraform 
  [registry](https://registry.terraform.io/modules/claranet/detectors/signalfx) and we recommend using it as source 
  instead of `git` which is more flexible but less future-proof.

* `environment`: Use this parameter to specify the 
  [environment](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#environment) used by this 
  instance of the module.
  Its value will be added to the `prefixes` list at the start of the [detector 
  name](https://github.com/claranet/terraform-signalfx-detectors/wiki/Templating#example).
  In general, it will also be used in `filter-tags` sub-module to apply a
  [filtering](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#filtering) based on our default 
  [tagging convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) by default.

* `notifications`: Use this parameter to define where alerts should be sent depending on their severity. It consists 
  of a Terraform [object](https://www.terraform.io/docs/configuration/types.html#object-) where each key represents an 
  available [detector rule severity](https://docs.signalfx.com/en/latest/detect-alert/set-up-detectors.html#severity) 
  and its value is a list of recipients. Every recipients must respect the [detector notification 
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding) 
  documentation to understand the recommended role of each severity.

There are other Terraform [variables](https://www.terraform.io/docs/configuration/variables.html) in 
[variables.tf](variables.tf) so check their description to customize the detectors behavior to fit your needs. Most of them are 
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables).
The [guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation will help you to use 
common mechanims provided by the modules like [multi 
instances](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#Multiple-instances).

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about 
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

* Kubernetes node heartbeat
* Kubernetes node status
* Kubernetes pod status phase
* Kubernetes pod terminated abnormally
* Kubernetes container killed by OOM
* Kubernetes deployment in CrashLoopBackOff
* Kubernetes daemonset in CrashLoopBackOff
* Kubernetes job from cronjob failed
* Kubernetes daemonsets not scheduled
* Kubernetes daemonsets not ready
* Kubernetes daemonsets misscheduled
* Kubernetes deployments available
* Kubernetes replicasets available
* Kubernetes replication_controllers available
* Kubernetes satefulsets ready

## How to collect required metrics?

This module uses metrics available from 
[monitors](https://docs.signalfx.com/en/latest/integrations/agent/monitors/_monitor-config.html)
available in the [SignalFx Smart 
Agent](https://github.com/signalfx/signalfx-agent). Check the "Related documentation" section for more 
information including the official documentation of this monitor.


### Agent

Here is the official [main 
documentation](https://docs.signalfx.com/en/latest/integrations/integrations-reference/integrations.kubernetes.html) for 
kubernetes including the `signalfx-agent` installation which must be installed as 
[daemonset](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) on your cluster.

### Monitors

The detectors in this module are based on metrics reported by the following monitors:

* [kubelet-stats](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubelet-stats.html)
* [kubernetes-cluster](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubernetes-cluster.html)

[Others](https://docs.signalfx.com/en/latest/integrations/kubernetes/k8s-monitors-observers.html#monitors-observers) 
exist to increase visibility or may be in future to enrich this modules or create new ones.

The `kubernetes-cluster` requires to enable the following `extraMetrics`:

* `kubernetes.job.completions`
* `kubernetes.job.active`
* `kubernetes.job.succeeded`
* `kubernetes.stateful_set.ready`
* `kubernetes.stateful_set.desired`

### Examples

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
    - kubernetes.job.completions
    - kubernetes.job.active
    - kubernetes.job.succeeded
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

__Note__: `clusterExtraMetrics` option is only available from the `1.7.1` version of the helm chart.


## Notes

This module should suit to every kubernetes clusters full managed or not and could be complete with others 
modules covering more data sources like `kubernetes-volumes` or use cases like `kubernetes-apiserver`.

### About `node_ready` detector

* it works as for most of the "heartbeat" detectors in this repo; using state property from cloud provider to ignore alerts on host which has been terminated / stopped (i.e. autoscaling group)
* the goal is to avoid any alert considered as normal because of host has been removed (automatically or manually)
* but the detector will always raise alert for environment outside the cloud while we do any way to know if "not ready node" comes from stopped / terminated host or a real problem.

### About `job_failed` detector

* it works only on job running from cronjob
* this will obviously raise an alert when a job is considered as failed from kubernetes point of view. Indeed, some pods could eventually fail or retry without to mark the job as failed
* but the alert will remain until you clean/purge jobs history. Indeed, even if a new, more recent, successful job has been running in the meantime the alert will continue until you delete the failed job


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Smart Agent monitor kubernetes-cluster](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubernetes-cluster.html)
* [Smart Agent monitor kubelet-stats](https://docs.signalfx.com/en/latest/integrations/agent/monitors/kubelet-stats.html)
