#! /bin/bash

PREFIX="HYPERTERM"
log "Begin Hyperterm config"

log "Installing Hyperterm config"
HYPERTERM_DIR="${HOME}"
HYPERTERM_MODULE_DIR="${DOTFILES_DIR}/hyperterm"
link "${HYPERTERM_DIR}/.hyperterm.js" "${HYPERTERM_MODULE_DIR}/js"
