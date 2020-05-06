#!/bin/bash
set -euo pipefail

REF=${1:-}
case $# in
    0)
        echo "Needs to provide git ref to use in modules"
        exit 42
        ;;
    1)
        TARGET="*"
        ;;
    2)
        TARGET=${2#"./"}
        ;;
    *)
        shift
        TARGET=$(echo "${@#"./"}" | sed 's/[[:space:]]*\.\// /g')
        ;;

esac
#echo "${REF} : ${TARGET}"

for i in $(find ${TARGET} -type f -not -path "*/.terraform/*" -name 'detectors-*.tf'); do
    name=$(dirname $i)
    echo -en "module \"signalfx-detectors-${name//\//-}\" {\n  source = \"github.com/claranet/terraform-signalfx-detectors.git//${name}?ref=${REF}\"\n\n  environment   = var.environment\n  notifications = [local.pagerduty_notification]\n}\n\n"
done
