#! /bin/zsh

PREFIX="VIM"
log "Begin Vim config"

log "Installing Vim config"
VIM_DIR="${HOME}"
VIM_MODULE_DIR="${DOTFILES_DIR}/vim"
link "${VIM_DIR}/.vimrc" "${VIM_MODULE_DIR}/rc"
mkdir -p "${VIM_DIR}/.vim"
link "${VIM_DIR}/.vim/colors" "${VIM_MODULE_DIR}/colors"
