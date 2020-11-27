#!/bin/bash
set -ue -o pipefail

case $# in
    0)
        TARGET="*"
        ;;
    1)
        TARGET=${1#"./"}
        ;;
    *)
        shift
        TARGET=$(echo "${@#"./"}" | sed 's/[[:space:]]*\.\// /g')
        ;;
esac

for i in $(find ${TARGET} -type f -not -path ".terraform/*" -name "detectors-*.tf"); do
    dir=$(dirname $i)
    cd $dir
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
    echo $(pwd)
    cd - > /dev/null
done

