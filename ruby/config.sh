#! /bin/bash

PREFIX="RUBY"
log "Begin Ruby config"

RUBY_DIR="${HOME}"
RUBY_MODULE_DIR="${DIR}/ruby"
link "${RUBY_DIR}/.ruby-version" "${RUBY_MODULE_DIR}/version"
