#!/bin/bash
set -euo pipefail
TMP="/tmp/out.tf"

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

module_vars=$(cat <<-EOF
	  environment   = var.environment
	  notifications = local.notifications
EOF
)
env_vars=$(terraform-config-inspect $(dirname $0)/../test --json | jq -cr '.variables[] | select(.required) | .name')

for i in $(find ${TARGET} -type f -not -path "*/.terraform/*" -name 'detectors-*.tf'); do
    dir=$(dirname $i)
    vars_string=""
    vars_list=$(terraform-config-inspect ${dir} --json | jq -cr '.variables[] | select(.required) | .name')
    for var in ${vars_list}; do
        [[ ${env_vars} =~ (^|[[:space:]])$var($|[[:space:]]) ]] ||
        echo "${module_vars}" | grep -q "^[[:space:]]*${var}" ||
        vars_string="${vars_string}\n${var}=\"fillme\""
    done
    cat <<-EOF > ${TMP}
	module "signalfx-detectors-${dir//\//-}" {
	  source = "github.com/claranet/terraform-signalfx-detectors.git//${dir}?ref=${REF}"

	  ${module_vars}$(echo -e ${vars_string})
	}

EOF
    terraform fmt -write=false -list=false -diff=false ${TMP} 2> /dev/null
done
