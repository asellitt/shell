#! /bin/bash

PREFIX="SSH"
log "Begin SSH config"

log "Installing SSH config"
SSH_DIR="${HOME}/.ssh"
SSH_MODULE_DIR="${DOTFILES_DIR}/ssh"
link "${SSH_DIR}/cybertron.config" "${SSH_MODULE_DIR}/cybertron.config"
