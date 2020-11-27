#!/bin/bash

if [ $# -lt 1 ]; then
    echo "You must provide module name as parameter (i.e. \"cloud-aws-alb\")"
    exit 1
fi

ARGS=$@
MOD_NAME=${ARGS// /-}
MOD_PATH="modules/${MOD_NAME}"
TEMPLATE_PATH="scripts/templates"
COMMON_TF="common"

function goto_root() {
    script_dir=$(dirname $0)
    if [[ "$script_dir" == "." ]]; then
        cd ../..
    else
        cd "$(dirname $(dirname $script_dir))"
    fi
}

set -ue -o pipefail
goto_root
pwd

if [[ -d "${MOD_PATH}" ]]; then
    echo "This module already exists, aborting."
    exit 2
else
    echo ${MOD_PATH}
    mkdir -p "${MOD_PATH}"
fi

for tf in common/module/*.tf; do 
    echo "Create symlink for ${tf}"
    ln -s ../../${tf} ${MOD_PATH}/${tf//\//-}
done

#echo "Generate variables from template"
#j2 ${TEMPLATE_PATH}/detector_vars.tf.j2 ${TEMPLATE_PATH}/examples/heartbeat-simple.yaml > ${MOD_PATH}/variables.tf
#echo "Generate simple detector from template"
#j2 ${TEMPLATE_PATH}/detector_res.tf.j2 ${TEMPLATE_PATH}/examples/heartbeat-simple.yaml > ${MOD_PATH}/detectors-${MOD_NAME##*-}.tf

