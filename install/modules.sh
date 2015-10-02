#! /bin/bash

echo "[INSTALL] Finding compatible modules in: ${DIR}"

for MODULES in */ ; do
    MODULE="${MODULES%/}"
    MODULE_DIR="${DIR}/${MODULE}"
    MODULE_CONFIG="${MODULE_DIR}/config.sh"

    if [ -f "$MODULE_CONFIG" ]; then
      echo "[INSTALL] Installing '${MODULE}' config"
      . $MODULE_CONFIG
    fi
done
