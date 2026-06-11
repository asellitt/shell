#!/usr/bin/env bash

module_supported() { return 0; }

module_install() {
  log "shell" "Installing shell config"
  link "${HOME}/.functions" "${DOTFILES_DIR}/modules/shell/functions"
  link "${HOME}/.aliases"   "${DOTFILES_DIR}/modules/shell/aliases"
  link "${HOME}/path"       "${DOTFILES_DIR}/modules/shell/path"
}
