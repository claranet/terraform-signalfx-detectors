#!/bin/bash
set -euo pipefail
TMP="/tmp/out.tf"

TARGET="${1:-}"
REF=${2:-\{revision\}}
MODULE="${TARGET##*modules/}"

module_vars=$(cat common/modules-args.txt)
exclude_vars="[$(echo "$module_vars" | sed 's/^[[:space:]]*\([a-zA-z0-9_]*\)[[:space:]]*=.*$/"\1"/' | sed ':a;N;$!ba;s/\n/, /g')]"
env_vars=$(terraform-config-inspect common/module --json | jq -cr '.variables[] | select(.required) | .name')

vars_rendering=""
unset vars
declare -A vars
while IFS="=" read -r key value; do
    vars[$key]="$value"
done < <(terraform-config-inspect --json ${TARGET} | jq --argjson ex "${exclude_vars}" -cr '.variables[] | select(.required) | select( .name as $a | $ex | index($a) | not ) | "\(.name)=\(.type)"')
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
module "signalfx-detectors-${MODULE/_/-}" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//${TARGET}?ref=${REF}"

  ${module_vars}$(echo -e ${vars_rendering})
}

EOF
terraform fmt -write=false -list=false -diff=false ${TMP} 2> /dev/null
