# Contributing

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [General](#general)
- [Detectors](#detectors)
- [Scope](#scope)
- [Example](#example)
- [Limits](#limits)
- [Criteria](#criteria)
- [Templating tips and rules](#templating-tips-and-rules)
  - [Modules structure](#modules-structure)
  - [Variables](#variables)
  - [Default values](#default-values)
  - [Filtering](#filtering)
  - [Severity](#severity)
  - [No data](#no-data)
  - [Documentation](#documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## General

* to propose change, simply submit a pull request (no issue required).
* if you are not sure, create it as draft this will allow code owners 
to help you.
* to ask for changes or for larger feature please open an issue to 
discuss.
* there are several issue templates available for common needs, please 
select it appropriately.

## Detectors

* to update existing detectors do the change directly in code.
* to add new detectors in existing modules use [the jinja 
generator](./scripts/templates/README.md).
* to add new module use [the gen_module.sh 
script](./scripts/gen_module.sh).

## Scope

The generic purpose goal of detectors in this repository will always 
limit the scope and the capabilities of these modules and also the 
approval criteria for changes.

It does not aim to cover too specific usage, setup or implementation 
because they will not be reusable.

It is a good start for a new project, to detect known anomalies and 
usual problems, in common situations. Each module is focused on 
monitor one target from its own internal view.

## Example

The metric collection is good to understand this:

* using highly complex formulas on multiple metrics from the same 
source is not a problem while it remains easy to setup and could be 
used in common situations.
* but a very simple detector using only two metrics from different 
sources could be too dificult to setup or require dependencies not 
available for most of the people.

For example, correlate a simple CPU usage of an host (fully generic) 
with the latency of his own application (collected by a custom metric or apm metric): the detector is simple, easy to deploy but requirements 
cannot be generic by design.

## Limits

Given that this scope and because we want to preserve homogeneity 
and maintainability every propositions could not be accepted. Also, 
the behavior which corresponds to the most of the people will always 
be favored compared to a better or more accurate approach which will 
only work in few situations.

This is also why we always recommend to create his own detectors, 
specifc to his use case, data sources and situations. They will be 
a good complement to get a global monitoring coverage.

## Criteria

Modules should be as much "plug and play" as possible, that means:

* be easy to configure and deploy
* works in most of the situations
* do not generate undersirable and predictable false alerts
* how to collect the metrics used in detectors should be 
provided, documented and available.
* should limit dependencies complexity as using too many or 
too different sources of metrics.

In short, the implementation could be complex but the usage must 
remain simple and useful for the community.

Sadly, full ready detectors which work everywhere by default is 
almost never possible. This is why templating tips and rules have 
been defined to help to customize their behavior at deployment 
to meet these criterias.

## Templating tips and rules

Terraform is rich of capabilities and allow to provide flexibility 
in configuration at deployment level.

A generic implementation customizable from user inputs with a 
good thinked structure and rich documentation could help to cover 
different specific situations and make it more generic.

Here are some templating rules and tips used to achieve this goal.
Some are required and others optional, more information 
in [the wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) 
for more details.

### Modules structure

Split your detectors into as much different modules as it could 
exist different predictable situations.

Having big modules with lot of detectors is not a problem itself 
but it increase the risk to not meet requirements.
Proposing atomic module will allow users to pick up only what they 
want without to disable some detectors.

Some examples:
* there is a `common` kubernetes module which should work in any 
cases. The `volume` detectors should be useful for everybody but 
has its own module while it requires additional agent configuration.
Every other `kubernetes` modules depend on the situation like
`ingress-nginx` useful only if Nginx Ingress Controller is used.
* GCP `cloud-sql` module is broken down into `common` (for all 
cloudsql instances) and engine specific module (for MySQL, 
PostgreSQL) and `failover` because it will raise false alert if 
deployed on master.

### Variables

Providing variables is the key to allow user adapt the behavior to 
meet their requirement keeping an uniq code base.

Some variables, considered as often useful at customization, are 
mandatory and so, represent a templating rule like:

* `*_aggregation_function` allows to set groups because dimensions
could change depending on the environment (vm or containers based 
infrastructure) or the configuration (`extraDimensions`, 
`disableHostDimensions`, ..)
* `*_transformation_function` could help to adapt sensitivity of 
alerting rules depending on the situation. For example, choosing 
`min` function with bigger timeframe and `>` threshold condition 
comparison will make the detector more tolerant.
* `filter_custom_*` to change included and / or excluded dimensions. 
This will allow user limit the alerting scope to part of its resources. 
It is possible to use multiple times the same module with different 
filters for different configuration (thresholds, ...)
* `*_threshold[_severity]` obviously give ability to change thresholds.
* `*_disabled[_severity]` make it possible to disable alerting rule(s).

### Default values

Providing (or not) default values for variables could help (or force) 
users to configure properly his monitoring.

* define default value as recommendation for everybody.
* do not define default value to make something specific obvious to user.
For example, if it is not possible to advice a good generic threshold, so 
do not set it will ask to user to define their own adapted to his use case.
* if alerting rule is too dangerous or tricky to deploy it by default, it 
is possible to disabled it by default to avoid to many false alerts and let 
advanced users to configure it even so.

### Filtering

Default filtering follows a convention to make it possible to:

* identify and separate the environment (i.e. `env` or `aws_tag_env` ..) 
because if we should monitor same things for every environments we also 
often want to define different recipients for example.
* define and delimit the scope of alerting on specific resources (i.e. apply 
detectors only on resources tagged with `sfx_monitored:true`
* both `env` and `sfx_monitored` represent the general convention but it 
could change depending on multiple factors. For example, GCP managed 
services labels are not synced as dimensions into SignalFx which make 
impossible to use `gcp_label_env` as we did for `aws_tag_env` and so 
we use the `project_id` dimension instead.

Custom filtering is always possible to use if user do not want or cannot 
follow this convention. One or both of `filter_custom_includes` and 
`filter_custom_excludes` could be used for that.

### Severity

Playing with [severities](https://docs.signalfx.com/en/latest/detect-alert/set-up-detectors.html#severity) 
will help to judge the criticity, the purpose and the scope of an alert. 
Here are the binding followed:

1. `Critical` for high priority alert waking up on call agent 24/7. 
Notification is sent to alerting tool like Pagerduty. Often related to 
availability or saturation of a resource.
2. `Major` is similar to `Critical` but for incident which could wait to be 
resolved during business hours. Also sent to alerting tool but with lower 
priority to alert avoid notification during graceful period (i.e. the night).
3. `Minor` will also generate notification but not disruptive this time like 
Slack or email. The alert should and will be treated when agent is available. 
Often related to performance degradation or proactive alerts.
4. `Warning` should not notify at all but log the alert in a low priority 
aggregator like a dashboard for proactive treatment or to help providing 
troubleshooting inputs in case of more important problem.
5. `Info` must not notify at all. Often used for debugging purpose or to 
notice not incident events.

__Note__: the `[*_]notifications` variables is a map/object which bind 
each severity on its own list of recipients.

### No data

Think to no data and handle it. Indeed, often we create detectors on 
real situations. It is good, but it is also important to think at how 
they behave in no or few, irregular data presence.

Take a load balancer 5xx errors percentage as example:

* In most of the cases, load balancer will continually receive, at least, 
few requests but not always. 
* But for testing environment, we could expect to receive irregular traffic 
depending on developpers tests.

Imagine load balancer receive only one request resulting in 5xx error and 
no more traffic after that during 24h: 

* The percentage of errors will be considered as high (100%)
* but not persisted enough time to want to raise alert
* however, witohut traffic, no more data and this is the last dapatoint 
which will determine the evaluation
* given that this last datapoint is in error so the detector will raise 
an alert which seem not relevant.

To avoid this kind of undesired behavior we encourage to use [extrapolation 
policy](https://docs.signalfx.com/en/latest/charts/chart-builder.html#extrapolation-policy-and-max-extrapolations-missing-datapoints) 
or [fill](https://developers.signalfx.com/signalflow_analytics/methods/fill_stream_method.html) signalflow method.


### Documentation

Adding a `README.md` at the root of the module providing:

* general documentation on the purpose of this module, its scope...
* requirements listing
* metrics collection how to (i.e. agent configuration sample)
* usage example
* notes about specificities or behavior

will help the users to understand and customize module to satisfy 
their own constaints.

