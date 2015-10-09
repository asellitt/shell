#! /bin/bash

PREFIX="VIM"
log "Begin Vim config"

log "Installing Vim config"
VIM_DIR="${HOME}"
VIM_MODULE_DIR="${DOTFILES_DIR}/vim"
link "${VIM_DIR}/.vimrc" "${VIM_MODULE_DIR}/rc"
