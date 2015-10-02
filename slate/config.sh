#! /bin/bash

PREFIX="SLATE"
log "Begin Slate config"

if [ `uname` != 'Darwin' ]; then
  log "This isn't OSX! Skipping config"
else
  log "OSX detected"

  if [ ! -d "/Applications/Slate.app" ]; then
      log "Looks like Slate is not installed. Skipping config"
  else
      log "   Found Slate"

      log "Installing Slate config"
      SLATE_DIR="${HOME}/.slate"
      SLATE_MODULE_DIR="${DIR}/slate"
      rm "${SLATE_DIR}"/slate 2>/dev/null
      ln -s "${SLATE_MODULE_DIR}"/slate "${SLATE_DIR}"/slate
  fi
fi
