## Notes

Agent config requires to enable following extra metrics:

- `cpu.percent`
- `cpu.throttling_data.throttled_time`

__Note__: this module is aims to be used with simple, docker only based hosts.
Prefer to use [../kubernetes](kubernetes) modules only for kubernetes infrastructure
while it does not make sens to monitor Docker in such environment and this will 
lead to duplicated detectors and alerts.
