#! /bin/bash

PREFIX="RUBY"
log "Begin Ruby config"

RUBY_DIR="${HOME}"
RUBY_MODULE_DIR="${DOTFILES_DIR}/ruby"

link "${RUBY_DIR}/.ruby-version" "${RUBY_MODULE_DIR}/version"
link "${RUBY_DIR}/.default-gems" "${RUBY_MODULE_DIR}/default-gems"

log "Installing Gem config"
GEM_DIR="${HOME}"
GEM_MODULE_DIR="${DOTFILES_DIR}/gem"
link "${GEM_DIR}/.gemrc" "${GEM_MODULE_DIR}/rc"

if gem spec pry > /dev/null 2>&1; then
    log "  Installing Pry config"
    PRY_DIR="${HOME}"
    PRY_MODULE_DIR="${DOTFILES_DIR}/pry"
    link "${PRY_DIR}/.pryrc" "${PRY_MODULE_DIR}/rc"
fi
