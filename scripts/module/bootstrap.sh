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
   [[ $MODULE != integration_* ]] &&
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
    ln -s ../../${tf} ${TARGET}/common-${tf#"common/module/"}
done
cat <<EOF > "${TARGET}/conf/readme.yaml"
documentations:

source_doc:
EOF

#echo "Generate variables from template"
#j2 ${TEMPLATES}/detector_vars.tf.j2 ${TEMPLATES}/examples/heartbeat-simple.yaml > ${TARGET}/variables.tf
#echo "Generate simple detector from template"
#j2 ${TEMPLATES}/detector_res.tf.j2 ${TEMPLATES}/examples/heartbeat-simple.yaml > ${TARGET}/detectors-${MODULE##*-}.tf

