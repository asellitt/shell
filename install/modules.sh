#! /bin/bash

. "${DIR}/install/functions.sh"

PREFIX="INSTALL"
log "Finding compatible modules in: ${DIR}"

for MODULES in */ ; do
    MODULE="${MODULES%/}"
    MODULE_DIR="${DIR}/${MODULE}"
    MODULE_CONFIG="${MODULE_DIR}/config.sh"

    if [ -f "$MODULE_CONFIG" ]; then
      PREFIX="INSTALL"
      log "Installing '${MODULE}' config"
      . $MODULE_CONFIG
    fi
done
