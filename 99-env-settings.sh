#!/bin/sh

if [ ! -z "${SETTINGS_FILE+x}" ]; then
  MODIFY_FILE="/usr/share/nginx/html/${SETTINGS_FILE}"
  COMPARE=""
  for VAR in $(jq -r '.|keys|@tsv' ${MODIFY_FILE})
  do
    eval VAL=\$$VAR
    [ -z $VAL ] || COMPARE="${COMPARE}|.$VAR=env.$VAR"
  done
  if [ ! -z "${COMPARE+x}" ]; then
    jq ".${COMPARE}" ${MODIFY_FILE} > ${MODIFY_FILE}.tmp && mv ${MODIFY_FILE}.tmp ${MODIFY_FILE}
  fi
fi
