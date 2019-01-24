#! /bin/bash

PREFIX="VSCODE"
log "Begin VSCode config"

if [ `uname` != 'Darwin' ]; then
  log "This isn't OSX! Skipping config"
else
  log "OSX detected"
  VSCODE_MODULE_DIR="${DOTFILES_DIR}/vscode"
  VSCODE_INSTALL_DIR="${HOME}/Library/Application Support/Code/User"

  if [ ! -d "${VSCODE_INSTALL_DIR}" ]; then
    log "Looks like VSCode is not installed. Skipping config"
  else
    log "Installing VSCode config"

    log "   Installing User Settings"
    link "${VSCODE_INSTALL_DIR}/settings.json" "${VSCODE_MODULE_DIR}/settings.json"
  fi
fi
