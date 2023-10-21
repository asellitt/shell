#! /bin/zsh

PREFIX="SSH"
log "Begin SSH config"

log "Installing SSH config"
SSH_DIR="${HOME}/.ssh"
SSH_MODULE_DIR="${DOTFILES_DIR}/ssh"
link "${SSH_DIR}/risdonia.config" "${SSH_MODULE_DIR}/risdonia.config"
