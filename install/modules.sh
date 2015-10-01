#! /bin/bash

$PREFIX="[INSTALL]"
echo "${PREFIX} Finding compatible modules in: ${DIR}"

for MODULE_DIR in */ ; do
    MODULE_CONFIG="${DIR}/${MODULE_DIR}config.sh"
    if [ -f "$MODULE_CONFIG" ]; then
      echo "${PREFIX} Installing $MODULE_DIR config"
      . $MODULE_CONFIG
    fi
done
