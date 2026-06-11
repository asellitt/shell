#!/usr/bin/env bash

module_supported() { return 0; }

module_install() {
  log "node" "Installing node config"

  link "${HOME}/.nvmrc"                "${DOTFILES_DIR}/modules/node/version"
  link "${HOME}/.default-npm-packages" "${DOTFILES_DIR}/modules/node/default-npm-packages"
}
