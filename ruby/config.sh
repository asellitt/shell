#! /bin/bash

PREFIX="RUBY"
log "Begin Ruby config"

log "Installing required ruby version manager"
brew_install 'chruby'
brew_install 'ruby-install'

RUBY_DIR="${HOME}"
RUBY_MODULE_DIR="${DOTFILES_DIR}/ruby"

if [[ $UPDATE == true ]]; then
  local ruby_version=$(cat "${RUBY_MODULE_DIR}/version" | sed -e "s/ruby-//")

  if hash ruby-install 2>/dev/null; then
    log "Fetching latest ruby definitions"
    ruby-install --latest
    log "Installing latest ruby: ${ruby_version}"
    ruby-install ruby "${ruby_version}" --no-reinstall

    log "Switching to correct ruby version: ${ruby_version}"
    source /usr/local/share/chruby/chruby.sh
    source /usr/local/share/chruby/auto.sh
  fi
fi

link "${RUBY_DIR}/.ruby-version" "${RUBY_MODULE_DIR}/version"

log "Installing Gem config"
GEM_DIR="${HOME}"
GEM_MODULE_DIR="${DOTFILES_DIR}/gem"
link "${GEM_DIR}/.gemrc" "${GEM_MODULE_DIR}/rc"

log "Update RubyGems"
gem update --system

# default gems
log "Installing handy gems"
if ! gem spec bundler > /dev/null 2>&1; then
  log "   Installing bundler"
  gem install bundler
fi
if ! gem spec pry > /dev/null 2>&1; then
  log "   Installing pry"
  gem install pry
fi
if ! gem spec pry-git > /dev/null 2>&1; then
  log "   Installing pry-git"
  gem install pry-git
fi
if ! gem spec pry-byebug > /dev/null 2>&1; then
  log "   Installing pry-byebug"
  gem install pry-byebug
fi
if ! gem spec pry-stack_explorer > /dev/null 2>&1; then
  log "   Installing pry-stack_explorer"
  gem install pry-stack_explorer
fi
if gem spec pry > /dev/null 2>&1; then
    log "   Installing Pry config"
    PRY_DIR="${HOME}"
    PRY_MODULE_DIR="${DOTFILES_DIR}/pry"
    link "${PRY_DIR}/.pryrc" "${PRY_MODULE_DIR}/rc"
fi
