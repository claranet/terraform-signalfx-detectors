#!/bin/bash
set -ue -o pipefail

TARGET="${1:-}"
cd ${TARGET}
# Ignore common locals for "terraform_unused_declarations"
for tflocal in $(grep '^[[:space:]]*[a-z0-9_]*[[:space:]]*=' common-locals.tf | awk '{print $1}'); do
    cat <<-EOF >> tmp-outputs.tf
    output "${tflocal}" {
      value = local.${tflocal}
    }

EOF
done
# Ignore common variables for "terraform_unused_declarations"
for tfvar in $(grep -E '^variable[[:space:]]+"' common-variables.tf | cut -d '"' -f2); do
    cat <<-EOF >> tmp-outputs.tf
    output "${tfvar}" {
      value = var.${tfvar}
    }

EOF
done

tflint --disable-rule=terraform_module_pinned_source --enable-rule=terraform_unused_declarations --loglevel=info
rm tmp-outputs.tf
