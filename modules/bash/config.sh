#!/usr/bin/env bash

module_supported() {
  [[ "$($SHELL --version 2>/dev/null)" == *"bash"* ]]
}

module_install() {
  log "bash" "Installing bash config"

  link "${HOME}/.bashrc"         "${DOTFILES_DIR}/modules/bash/rc"
  link "${HOME}/.bash_profile"   "${DOTFILES_DIR}/modules/bash/profile"
  link "${HOME}/.bash_include"   "${DOTFILES_DIR}/modules/bash/include"
  link "${HOME}/.bash_logout"    "${DOTFILES_DIR}/modules/bash/logout"
  link "${HOME}/.bash_aliases"   "${DOTFILES_DIR}/modules/shell/aliases"
  link "${HOME}/.bash_functions" "${DOTFILES_DIR}/modules/shell/functions"
}
