#! /bin/bash

PREFIX="GEM"
log "Begin Gem config"

log "Installing Gem config"
GEM_DIR="${HOME}"
GEM_MODULE_DIR="${DIR}/gem"
link "${GEM_DIR}/.gemrc" "${GEM_MODULE_DIR}/rc"

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
    PRY_MODULE_DIR="${DIR}/pry"
    link "${PRY_DIR}/.pryrc" "${PRY_MODULE_DIR}/rc"
fi
