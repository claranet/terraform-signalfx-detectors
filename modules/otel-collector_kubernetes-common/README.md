# KUBERNETES-COMMON SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Agent](#agent)
  - [Monitors](#monitors)
  - [Examples](#examples)
  - [Metrics](#metrics)
- [Notes](#notes)
  - [About `node_ready` detector](#about-node_ready-detector)
  - [About `job_failed` detector](#about-job_failed-detector)
  - [About `oom_killed` detector](#about-oom_killed-detector)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/)
[module](https://www.terraform.io/language/modules/syntax) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-otel-collector-kubernetes-common" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/otel-collector_kubernetes-common?ref={revision}"

  environment   = var.environment
  notifications = local.notifications
}
```

Note the following parameters:

* `source`: Use this parameter to specify the URL of the module. The double slash (`//`) is intentional  and required.
  Terraform uses it to specify subfolders within a Git repo (see [module
  sources](https://www.terraform.io/language/modules/sources)). The `ref` parameter specifies a specific Git tag in
  this repository. It is recommended to use the latest "pinned" version in place of `{revision}`. Avoid using a branch
  like `master` except for testing purpose. Note that every modules in this repository are available on the Terraform
  [registry](https://registry.terraform.io/modules/claranet/detectors/signalfx) and we recommend using it as source
  instead of `git` which is more flexible but less future-proof.

* `environment`: Use this parameter to specify the
  [environment](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#environment) used by this
  instance of the module.
  Its value will be added to the `prefixes` list at the start of the [detector
  name](https://github.com/claranet/terraform-signalfx-detectors/wiki/Templating#example).
  In general, it will also be used in the `filtering` internal sub-module to [apply
  filters](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#filtering) based on our default
  [tagging convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) by default.

* `notifications`: Use this parameter to define where alerts should be sent depending on their severity. It consists
  of a Terraform [object](https://www.terraform.io/language/expressions/type-constraints#object) where each key represents an available
  [detector rule severity](https://docs.splunk.com/observability/alerts-detectors-notifications/create-detectors-for-alerts.html#severity)
  and its value is a list of recipients. Every recipients must respect the [detector notification
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding)
  documentation to understand the recommended role of each severity.

These 3 parameters alongs with all variables defined in [common-variables.tf](common-variables.tf) are common to all
[modules](../) in this repository. Other variables, specific to this module, are available in
[variables-gen.tf](variables-gen.tf).
In general, the default configuration "works" but all of these Terraform
[variables](https://www.terraform.io/language/values/variables) make it possible to
customize the detectors behavior to better fit your needs.

Most of them represent usual tips and rules detailled in the
[guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation and listed in the
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables) dedicated documentation.

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Kubernetes heartbeat|X|-|-|-|-|
|Kubernetes hpa scale exceeded capacity|-|X|-|-|-|
|Kubernetes node status|-|X|X|-|-|
|Kubernetes pod phase status|-|X|X|X|-|
|Kubernetes pod terminated abnormally|-|X|-|-|-|
|Kubernetes container killed by oom|-|X|-|-|-|
|Kubernetes deployment in crashloopbackoff|-|X|-|-|-|
|Kubernetes daemonset in crashloopbackoff|-|X|-|-|-|
|Kubernetes job from cronjob failed|-|X|-|-|-|
|Kubernetes daemonsets scheduled|X|-|-|-|-|
|Kubernetes daemonsets ready|X|-|-|-|-|
|Kubernetes daemonsets misscheduled|X|-|-|-|-|
|Kubernetes deployments available|X|-|-|-|-|
|Kubernetes replicasets available|X|-|-|-|-|
|Kubernetes replication controllers available|X|-|-|-|-|
|Kubernetes statefulsets ready|X|-|-|-|-|

## How to collect required metrics?

This module deploys detectors using metrics reported by the
[Receivers](https://github.com/open-telemetry/opentelemetry-collector/blob/master/receiver/README.md) of the [OpenTelemetry
Collector](https://opentelemetry.io/docs/collector/), a new vendor-agnostic agent which replaces the [SignalFx Smart
Agent](https://github.com/signalfx/signalfx-agent/) in Splunk Observability (fka SignalFx).

It is surely more powerful but therefore more complex so give a look to the [official documentation](https://opentelemetry.io/docs/collector/configuration/)
to learn how to configure Otel Collector and your receivers properly.

The full list of available receivers are distributed through different sources:
- the [officially supported receivers](https://github.com/open-telemetry/opentelemetry-collector/tree/main/receiver) from the core repository
- the [contributions based receivers](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver) which represents
a superset of the core repository.
- the [splunk specific receivers](https://github.com/signalfx/splunk-otel-collector/tree/main/internal/receiver) from the Splunk distro of
the OpenTelemetry Collector based on the contributions repository.


Check the [Related documentation](#related-documentation) section for more detailed and specific information about this module dependencies.

### Agent

Here is the official [main
documentation](https://github.com/signalfx/integrations/blob/master/kubernetes/SMART_AGENT_MONITOR.md) for
kubernetes including the `signalfx-agent` installation which must be installed as
[daemonset](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) on your cluster.

### Monitors

The detectors in this module are based on metrics reported by the following monitors:

* [kubelet-metrics](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/kubelet-metrics.md) for Kubernetes `>= 1.18`
* [kubelet-stats](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/kubelet-stats.md) for Kubernetes `< 1.18
* [kubernetes-cluster](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/kubernetes-cluster.md)

The `kubernetes-cluster` requires to enable the following `extraMetrics`:

* `k8s.job.desired_successful_pods`
* `k8s.job.active_pods`
* `k8s.job.successful_pods`
* `k8s.statefulset.ready_pods`
* `k8s.statefulset.desired_pods`
* `k8s.hpa.max_replicas`
* `k8s.hpa.desired_replicas`

### Examples

Here is a sample configuration fragment for SignalFx Agent with `kubernetes-cluster` monitor:

```yaml
monitors:
- type: kubernetes-cluster
  extraMetrics:
    - k8s.job.desired_successful_pods
    - k8s.job.active_pods
    - k8s.job.successful_pods
    - k8s.statefulset.ready_pods
    - k8s.statefulset.desired_pods
    - k8s.hpa.max_replicas
    - k8s.hpa.desired_replicas
```

You can replace `kubernetes-cluster` with `openshift-cluster` you monitor Openshift Kubernetes.

Then add the monitor `kubelet-metrics` for Kubernetes version `>= 1.18`. Example for GKE:

```yaml
- type: kubelet-metrics
  kubeletAPI:
    authType: serviceAccount
  usePodsEndpoint: true
```

__Note__: `usePodsEndpoint: true` allows to enhance containers metrics with `container.id` dimension.

If you use a Kubernetes version `< 1.18` you have to replace `kubelet-metrics` monitor by `kubelet-stats`.
Example for GKE:

```yaml
- type: kubelet-stats
  kubeletAPI:
    authType: serviceAccount
  datapointsToExclude:
  - dimensions:
      container.image.name:
      - '*pause-amd64*'
      - 'k8s.gcr.io/pause*'
    metricNames:
      - '*'
      - '!*network*'
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
  - k8s.job.desired_successful_pods
  - k8s.job.active_pods
  - k8s.job.successful_pods
  - k8s.statefulset.ready_pods
  - k8s.statefulset.desired_pods
  - k8s.hpa.max_replicas
  - k8s.hpa.desired_replicas

# Required to use "system-generic" module
loadPerCPU: true

# Required to use "kubernetes-volumes" module
gatherVolumesMetrics: true

# Example of optional monitors to add for more cool metrics
monitors:
  - type: prometheus-exporter
    discoveryRule: container.image.name =~ "nginx-ingress-controller" && port == 10254
    port: 10254
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!nginx_ingress_controller_requests'
        - '!nginx_ingress_controller_ingress_upstream_latency_seconds'
```

__Note__: `clusterExtraMetrics` option is only available from the `1.7.1` version of the helm chart.


### Metrics


Here is the list of required metrics for detectors in this module.

* `k8s.container.ready`
* `k8s.container.restarts`
* `k8s.daemonset.current_scheduled_nodes`
* `k8s.daemonset.desired_scheduled_nodes`
* `k8s.daemonset.misscheduled_nodes`
* `k8s.daemonset.ready_nodes`
* `k8s.deployment.available`
* `k8s.deployment.desired`
* `k8s.hpa.desired_replicas`
* `k8s.hpa.max_replicas`
* `k8s.job.active_pods`
* `k8s.job.desired_successful_pods`
* `k8s.job.successful_pods`
* `k8s.node.condition_ready`
* `k8s.pod.phase`
* `k8s.replicaset.available`
* `k8s.replicaset.desired`
* `k8s.replication_controller.available`
* `k8s.replication_controller.desired`
* `k8s.statefulset.desired_pods`
* `k8s.statefulset.ready_pods`


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

### About `oom_killed` detector

* default transformation function is used to avoid the detector to flap repeatedly
* if unset, expect the detector to send several alerts per minute


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Splunk Observability integrations](https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html)
* [Smart Agent monitor kubernetes-cluster](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/kubernetes-cluster.md)
* [Smart Agent monitor kubelet-stats](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/kubelet-stats.md)
* [Smart Agent monitor kubelet-metrics](https://github.com/signalfx/signalfx-agent/blob/main/docs/monitors/kubelet-metrics.md)
* [Splunk Observability integration](https://docs.splunk.com/Observability/gdi/kubernetes-cluster/kubernetes-cluster.html)
