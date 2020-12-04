#!/bin/bash
set -ue -o pipefail

TARGET="${1:-}"
cd ${TARGET}
names=$(terraform-config-inspect --json | jq -rc '.managed_resources[].name')
echo "Generate module outputs to \"${TARGET}/outputs.tf\""
> outputs.tf
for name in ${names}; do
    cat <<-EOF >> outputs.tf
output "${name}" {
  description = "Detector resource for ${name}"
  value       = signalfx_detector.${name}
}

EOF
done

