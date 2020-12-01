#!/bin/bash
set -ue -o pipefail

TARGET="${1:-}"
MODULE=${TARGET#"modules/"}
set -x

if ! compgen -G ${TARGET}/conf/detector-*.yaml > /dev/null; then
    exit
fi
for dst in variables detectors; do
    > ${TARGET}/${dst}-gen.tf
done
for detector in ${TARGET}/conf/detector-*.yaml; do
    for dst in variables detectors; do
        j2 ./scripts/templates/$(echo ${dst} | sed 's/detectors/detector/').tf.j2 ${detector} >> ${TARGET}/${dst}-gen.tf
    done
done

