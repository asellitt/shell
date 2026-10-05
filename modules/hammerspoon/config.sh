#!/usr/bin/env bash

module_supported() { is_macos; }

module_install() {
  log "hmmrspn" "Installing Hammerspoon"
  install_from_manifest "${DOTFILES_DIR}/modules/hammerspoon/install.conf"

  log "hmmrspn" "Installing Hammerspoon config"
  mkdir -p "${HOME}/.hammerspoon"
  link "${HOME}/.hammerspoon/init.lua" "${DOTFILES_DIR}/modules/hammerspoon/init.lua"
}
