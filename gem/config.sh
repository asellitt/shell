#! /bin/bash

PREFIX="GEM"
log "Begin Gem config"

log "Installing Gem config"
GEM_DIR="${HOME}"
GEM_MODULE_DIR="${DIR}/gem"
link "${GEM_DIR}/.gemrc" "${GEM_MODULE_DIR}/rc"

# default gems
log 'Installing handy gems'
if ! gem spec bundler > /dev/null 2>&1; then
    log '  Installing bundler'
    gem install bundler
fi
if ! gem spec pry > /dev/null 2>&1; then
    log '  Installing pry'
    gem install pry
fi
