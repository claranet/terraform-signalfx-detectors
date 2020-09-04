# MIDDLEWARE Varnish SignalFx detectors

## Prerequisites

This monitor uses the **varnishstat** command. The **signalfx-agent** user must be
able to use this command.

### Varnish 4 specific part

In the **/etc/default/varnishncsa** file:
```
VARNISHNCSA_ENABLED=1
```

Following by :

```bash
systemctl start varnishncsa.service
systemctl enable varnishncsa.service
```

### All varnish versions

Then, you need to add the **signalfx-agent** user to the varnish group :

```bash
usermod -a -G varnish signalfx-agent
```

## How to use this module

```hcl
module "signalfx-detectors-middleware-varnish" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//middleware/varnish?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}
```

## Purpose

Creates SignalFx detectors with the following checks:
- varnish_backend_failed
- varnish_threads_number
- varnish_session_dropped
- varnish_cache_hit_rate
- varnish_memory_usage

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| varnish_backend_failed_threshold_critical" | Varnish Backed Failed Detection threshold critical | number | 0 | yes |
| varnish_backend_req_threshold_critical" | Varnish Backed Request Detection threshold critical | number | 1500 | yes |
| varnish_session_dropped_threshold_critical | Varnish Session Dropped Detection threshold critical | number | 0 | yes |
| varnish_cache_hit_rate_threshold_major | Varnish Cache Hit threshold major | number | 80 | yes |
| varnish_cache_hit_rate_threshold_warning | Varnish Cache Hit threshold warning | number | 90 | yes |
| varnish_threads_threshold_critical | Varnish Cache Hit threshold critical | number | 90 | yes |
| varnish_memory_usage_threshold_warning | Varnish Memory Usage threshold warning | number | 80 | yes |
| varnish_memory_usage_threshold_critical | Varnish Memory Usage threshold critical | number | 90 | yes |
