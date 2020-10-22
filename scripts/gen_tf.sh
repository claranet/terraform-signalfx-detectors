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
exclude_vars="[$(echo "$module_vars" | sed 's/^[[:space:]]*\([a-zA-z0-9_]*\)[[:space:]]*=.*$/"\1"/' | sed ':a;N;$!ba;s/\n/, /g')]"
env_vars=$(terraform-config-inspect $(dirname $0)/../test --json | jq -cr '.variables[] | select(.required) | .name')

for i in $(find ${TARGET} -type f -not -path "*/.terraform/*" -name 'detectors-*.tf'); do
    dir=$(dirname $i)
    vars_rendering=""
    unset vars
    declare -A vars
    while IFS="=" read -r key value; do
        vars[$key]="$value"
    done < <(terraform-config-inspect ${dir} --json | jq --argjson ex "${exclude_vars}" -cr '.variables[] | select(.required) | select( .name as $a | $ex | index($a) | not ) | "\(.name)=\(.type)"')
    for var in ${!vars[@]}; do
        case ${vars[$var]} in
            string)
                val='"fillme"'
                ;;
            number)
                val=42
                ;;
            *)
                val=null
                ;;
        esac
        [[ ${env_vars} =~ (^|[[:space:]])$var($|[[:space:]]) ]] ||
        vars_rendering="${vars_rendering}\n${var}=$val"
    done
    cat <<-EOF > ${TMP}
	module "signalfx-detectors-${dir//\//-}" {
	  source = "github.com/claranet/terraform-signalfx-detectors.git//${dir}?ref=${REF}"

	  ${module_vars}$(echo -e ${vars_rendering})
	}

EOF
    terraform fmt -write=false -list=false -diff=false ${TMP} 2> /dev/null
done
