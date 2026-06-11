#!/usr/bin/env bash

module_supported() {
  is_macos && [[ -d "/Applications/Slate.app" ]]
}

module_install() {
  log "slate" "Installing Slate config"
  link "${HOME}/.slate" "${DOTFILES_DIR}/modules/slate/slate"
}
