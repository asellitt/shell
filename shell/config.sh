#! /bin/zsh

PREFIX="SHELL"
log "Begin Shell config"

SHELL_DIR="${HOME}"
SHELL_MODULE_DIR="${DOTFILES_DIR}/shell"
link "${SHELL_DIR}/path" "${SHELL_MODULE_DIR}/path"
link "${SHELL_DIR}/.functions" "${SHELL_MODULE_DIR}/functions"
link "${SHELL_DIR}/.aliases" "${SHELL_MODULE_DIR}/aliases"
