#! /bin/zsh

PREFIX="ITERM"
log "Begin iTerm config"

if [ `uname` != 'Darwin' ]; then
  log "This isn't OSX! Skipping config"
else
  log "OSX detected"
  ITERM_MODULE_DIR="${DOTFILES_DIR}/iterm"
  ITERM_PREFERENCES_DIR="${HOME}/Library/Preferences"

  log "Installing preferences"
  link "${ITERM_PREFERENCES_DIR}/com.googlecode.iterm2.plist" "${ITERM_MODULE_DIR}/com.googlecode.iterm2.plist"
fi
