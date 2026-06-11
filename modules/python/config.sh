#!/usr/bin/env bash

module_supported() { return 0; }

module_install() {
  log "python" "Installing python config"

  link "${HOME}/.default-python-packages" "${DOTFILES_DIR}/modules/python/default-python-packages"
}
