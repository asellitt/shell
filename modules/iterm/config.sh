#!/usr/bin/env bash

module_supported() { is_macos; }

module_install() {
  log "iterm" "Installing iTerm config"

  defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${DOTFILES_DIR}/modules/iterm"
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
}
