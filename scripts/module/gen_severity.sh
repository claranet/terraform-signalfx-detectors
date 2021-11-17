#!/bin/bash
set -ue -o pipefail

# Ensure same sort behavior if run outside the container
export LC_COLLATE=C

TARGET="${1:-}"
MODULE=${TARGET#"modules/"}
SEV_GLOBAL="${SEV_GLOBAL:-false}"

if [[ ${SEV_GLOBAL} == "true" ]]; then
    echo -e "## $(echo ${MODULE} | cut -d'_' -f 2)\n"
fi
echo -e "|Detector|Critical|Major|Minor|Warning|Info|\n|---|---|---|---|---|---|"

for tf in ${TARGET}/detectors-*.tf; do
    line_table=""
    while read line
    do
        if [[ "$line" =~ ^name ]]; then
            if [[ ! -z ${line_table} ]]; then
                echo "|"$line_table"|"$crit"|"$maj"|"$min"|"$warn"|"$info"|"
            fi
            detector=$(echo "$line" | sed -n 's/^.*name.*=.*detector_name_prefix.*"\(.*\)")$/\1/p')
            crit="-"
            maj="-"
            min="-"
            warn="-"
            info="-"
            line_table=$detector
        fi
        if [[ "$line" =~ ^severity ]]; then
            severity=$(echo "$line" | sed -n 's/^.*severity.*=.*"\(.*\)"$/\1/p')
            case $severity in
                Critical)
                    crit="X"
                ;;
                Major)
                    maj="X"
                ;;
                Minor)
                    min="X"
                ;;
                Warning)
                    warn="X"
                ;;
                Info)
                    info="X"
                ;;
            esac
        fi
    done < ${tf}
    echo "|"$line_table"|"$crit"|"$maj"|"$min"|"$warn"|"$info"|"
done
echo -e "\n"
