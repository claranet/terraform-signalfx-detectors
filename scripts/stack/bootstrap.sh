#!/bin/bash
set -euo pipefail

DST="stack"

rm -f ${DST}/*.tf
cp -a common/stack/*.tf ${DST}/
