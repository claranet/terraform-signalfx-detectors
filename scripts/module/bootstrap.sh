#!/bin/bash
set -ue -o pipefail

if [ $# -lt 1 ]; then
    echo "You must provide module name as parameter (i.e. \"integration_aws-alb\")"
    exit 1
fi

ARGS=$@
MODULE=${ARGS// /-}
if [[ $MODULE != smart-agent_* ]] &&
   [[ $MODULE != otel-collector_* ]] &&
   [[ $MODULE != prometheus-exporter_* ]] &&
   [[ $MODULE != integration_* ]] &&
   [[ $MODULE != fame_* ]] &&
   [[ $MODULE != organization_* ]] &&
   [[ $MODULE != internal_* ]] ; then
    echo "Module name should start with known source as prefix like \"smart-agent_\""
    exit 2
fi
TARGET="modules/${MODULE}"
TEMPLATES="scripts/templates"

if [[ -d "${TARGET}" ]]; then
    echo "This module already exists, aborting."
    exit 2
fi

echo "Bootstrap module code in \"${TARGET}\""
mkdir -p "${TARGET}/conf"
for tf in common/module/*.tf; do
    src_filename=$(basename $tf)
    dst_filename="common-${src_filename}"
    if [[ $src_filename == filters-* ]]; then
        source_name=$(basename ${src_filename#"filters-"} .tf)
        if [[ $MODULE != $source_name* ]]; then
            continue
        else
            dst_filename="common-filters.tf"
        fi
    fi
    ln -s ../../${tf} ${TARGET}/${dst_filename}
done
if ! [ -L ${TARGET}/common-filters.tf ]; then
    cat <<EOF > "${TARGET}/filters.tf"
locals {
  # See https://dev.splunk.com/observability/docs/signalflow/functions/filter_function/ to create filters string
  filters = "filter('put a generic and source relevant', 'filter policy here') and filter('do not hesitate to use variable like', '\${var.environment}')"
}

EOF
fi

cat <<EOF > "${TARGET}/tags.tf"
locals {
  tags = ["$(echo $MODULE | cut -d'_' -f1)", "$(echo $MODULE | cut -d'_' -f2)"]
}

EOF

cat <<EOF > "${TARGET}/conf/readme.yaml"
documentations:

source_doc:
EOF

#echo "Generate variables from template"
#j2 ${TEMPLATES}/detector_vars.tf.j2 ${TEMPLATES}/examples/heartbeat-simple.yaml > ${TARGET}/variables.tf
#echo "Generate simple detector from template"
#j2 ${TEMPLATES}/detector_res.tf.j2 ${TEMPLATES}/examples/heartbeat-simple.yaml > ${TARGET}/detectors-${MODULE##*-}.tf

