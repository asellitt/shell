#! /bin/bash

PREFIX="[SSH]"
echo "${PREFIX} Begin SSH config"

echo "${PREFIX} Installing SSH config"

SSH_DIR="${HOME}/.ssh"
SSH_MODULE_DIR="${DIR}/ssh"
rm "${SSH_DIR}"/cybertron.config 2>/dev/null
ln -s "${SSH_MODULE_DIR}"/cybertron.config "${SSH_DIR}"/cybertron.config
