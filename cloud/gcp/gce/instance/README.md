## Notes

While SignalFx does not support `label` sync from GCE the default filtering policy relies on `metadata` instead:

* add metadata at the instance (or project) level, e.g.:

    - `gcloud compute instances add-metadata myinstance --zone=europe-west1-c --metadata sfx_env=true`
    - `gcloud compute instances add-metadata myinstance --zone=europe-west1-c --metadata sfx_monitored=true`

* whitelist metadata fields at the SignalFx's GCP integration level (requires SignalFx terraform provider v4.22.0+, see https://docs.signalfx.com/en/latest/integrations/google-cloud-platform.html#compute-engine-instance).

