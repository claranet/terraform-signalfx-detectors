module "signalfx-detectors-smart-agent-system-common-advanced" {

  # The minimal configuration same as the basic.tf example file:
  # -------------------------------------------------------------------------------------------------------
  source        = "claranet/detectors/signalfx//modules/smart-agent_system-common"
  version       = ">= 1.7.0, < 2.0.0"
  environment   = var.environment
  notifications = local.notifications_devnull
  # -------------------------------------------------------------------------------------------------------

  # Customize the alert triggering related conditions:
  # -------------------------------------------------------------------------------------------------------
  # Fine tune the disk detector to make it more tolerant
  disk_space_threshold_critical      = 95                # increase the threshold for critical rule
  disk_space_threshold_major         = 90                # increase the threshold for major rule
  disk_space_transformation_function = ".min(over='5m')" # using min function to wait for the timeframe
  # Using a "min" function with ">" condition will trigger alert only if threshold keep reached during the
  # full timeframe whereas the "max" function will trigger alert immediately if threshold is broken
  # Be careful, this logic is reversed if the condition uses "<" comparison (instead of ">" here).
  # -------------------------------------------------------------------------------------------------------

  # Adapt the configuration better feet our use case and monitored resources:
  # -------------------------------------------------------------------------------------------------------
  # Override the aggregation to change on which groups/dimensions the detector apply to
  disk_space_aggregation_function = ".max(by=['host'])" # take the max disk on the host
  # While there is no default value here, it will apply to every single existing MTS and this will go down
  # to check each disk present on the host and the function itself does nothing with a single mts but
  # if we aggregate to a greater "host" level like here so the function will be applied to multiple MTS
  # (once for each disk of the same host), here we take the "max" to check the most used disk of the host.
  # In general, it is better to not aggregate (empty like the default value here) when not required but
  # sometimes a detector can give better result if aggregated to multiple resources.

  # Override the tip to customize part of the body message sent by alerts
  disk_space_tip = <<-EOF
    Disk space growing often comes from too many logs. Check for big files using `ncdu` command and
    consider decrease the logging level of the application (or even better, forward logs instead
    of store them on the local host).
EOF
  # -------------------------------------------------------------------------------------------------------

  # Enjoy all features from the module:
  # -------------------------------------------------------------------------------------------------------
  # Disabling the cpu detector enabled by default because we monitor user experience which is
  # a far better metric to alert on than the cpu which is not a problem itself
  cpu_disabled = true
  # In contrast, enabling the forecast detector disabled by default
  disk_running_out_disabled = false

  # Add runbook url to an internal documentation or specific dashboard
  runbook_url = "https://my-awesome-dashboard.com"
  # this will apply to all detectors but you can also set it per detector basis
  # -------------------------------------------------------------------------------------------------------
}

