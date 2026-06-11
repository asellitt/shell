#!/usr/bin/env bash

module_supported() { return 0; }

module_install() {
  log "vim" "Installing vim config"

  link "${HOME}/.vimrc" "${DOTFILES_DIR}/modules/vim/rc"
  mkdir -p "${HOME}/.vim"
  link "${HOME}/.vim/colors" "${DOTFILES_DIR}/modules/vim/colors"
}
