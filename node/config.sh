#! /bin/zsh

PREFIX="NODE"
log "Begin Node config"

NODE_DIR="${HOME}"
NODE_MODULE_DIR="${DOTFILES_DIR}/node"

link "${NODE_DIR}/.nvmrc" "${NODE_MODULE_DIR}/version"
link "${NODE_DIR}/.default-npm-packages" "${NODE_MODULE_DIR}/default-npm-packages"
