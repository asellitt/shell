#! /bin/bash

PREFIX="BASH"
log "Begin Bash config"

log "Installing Bash config"
BASH_DIR="${HOME}"
BASH_MODULE_DIR="${DIR}/bash"
link "${BASH_DIR}/.bashrc" "${BASH_MODULE_DIR}/rc"
link "${BASH_DIR}/.bash_profile" "${BASH_MODULE_DIR}/profile"
link "${BASH_DIR}/.bash_include" "${BASH_MODULE_DIR}/include"
link "${BASH_DIR}/.bash_aliases" "${BASH_MODULE_DIR}/aliases"
link "${BASH_DIR}/.bash_functions" "${BASH_MODULE_DIR}/functions"
link "${BASH_DIR}/.bash_logout" "${BASH_MODULE_DIR}/logout"
link "${BASH_DIR}/path" "${BASH_MODULE_DIR}/path"
