#! /bin/bash

PREFIX="RBENV"
log "Begin Rbenv config"

if ! hash rbenv 2>/dev/null ; then
    log "Looks like Rbenv is not installed. Skipping config"
else
    log "   Found Rbenv"

    log "Installing Rbenv config"
    RBENV_DIR="${HOME}"
    RBENV_MODULE_DIR="${DIR}/rbenv"
    link "${RBENV_DIR}/.rbenv-version" "${RBENV_MODULE_DIR}/version"
fi
