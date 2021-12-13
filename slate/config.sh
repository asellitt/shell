#! /bin/zsh

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
      SLATE_DIR="${HOME}"
      SLATE_MODULE_DIR="${DOTFILES_DIR}/slate"
      link "${SLATE_DIR}/.slate" "${SLATE_MODULE_DIR}/slate"
  fi
fi
