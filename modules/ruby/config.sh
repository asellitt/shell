#!/usr/bin/env bash

module_supported() { return 0; }

module_install() {
  log "ruby" "Installing ruby config"

  link "${HOME}/.ruby-version"  "${DOTFILES_DIR}/modules/ruby/version"
  link "${HOME}/.default-gems"  "${DOTFILES_DIR}/modules/ruby/default-gems"
  link "${HOME}/.gemrc"         "${DOTFILES_DIR}/modules/ruby/gem/rc"

  if gem spec pry > /dev/null 2>&1; then
    log "ruby" "Installing pry config"
    link "${HOME}/.pryrc" "${DOTFILES_DIR}/modules/ruby/pry/rc"
  fi
}
