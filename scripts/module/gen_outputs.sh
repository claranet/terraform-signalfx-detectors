#!/bin/bash
set -ue -o pipefail

TARGET="${1:-}"
cd ${TARGET}
names=$(terraform-config-inspect --json | jq -rc '.managed_resources[].name')
> outputs.tf
for name in ${names}; do
    cat <<-EOF >> outputs.tf
output "${name}" {
  description = "Detector resource for ${name}"
  value       = signalfx_detector.${name}
}

EOF
done

