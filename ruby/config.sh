#! /bin/bash

PREFIX="RUBY"
log "Begin Ruby config"

log "Installing required ruby version manager"
package 'chruby'
package 'ruby-install'

if hash ruby-install 2>/dev/null; then
  log "Installing latest ruby"
  ruby-install ruby --no-reinstall
fi

RUBY_DIR="${HOME}"
RUBY_MODULE_DIR="${DOTFILES_DIR}/ruby"
link "${RUBY_DIR}/.ruby-version" "${RUBY_MODULE_DIR}/version"
