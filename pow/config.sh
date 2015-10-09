#! /bin/bash

PREFIX="POW"
log "Begin Pow config"

if [ `uname` != 'Darwin' ]; then
  log "This isn't OSX! Skipping config"
else
  log "OSX detected"

  POW_ROOT="${HOME}/Library/Application Support/Pow"
  if [ ! -d "${POW_ROOT}" ]; then
      log "Looks like Pow is not installed. Skipping config"
  else
      log "   Found Pow"

      log "Installing Pow config"
      POW_DIR="${HOME}"
      POW_MODULE_DIR="${DOTFILES_DIR}/pow"
      link "${POW_DIR}/.powconfig" "${POW_MODULE_DIR}/config"
  fi
fi
