#! /bin/bash

PREFIX="RUBY"
log "Begin Ruby config"

log "Installing required ruby version manager"
brew_install 'chruby'
brew_install 'ruby-install'

if [[ $UPDATE == true ]]; then
  if hash ruby-install 2>/dev/null; then
    log "Fetching latest ruby definitions"
    ruby-install --latest
    log "Installing latest ruby"
    ruby-install ruby --no-reinstall
  fi
fi

RUBY_DIR="${HOME}"
RUBY_MODULE_DIR="${DOTFILES_DIR}/ruby"
link "${RUBY_DIR}/.ruby-version" "${RUBY_MODULE_DIR}/version"
