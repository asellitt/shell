#! /bin/bash

PREFIX="APPS"
log "Begin Apps config"

log "Tapping the caskroom"
if hash boxen 2>/dev/null; then
  log "  Boxen detected, skipping tap"
elif hash brew 2>/dev/null; then
  log "  Brew detected, tapping caskroom"
  brew tap caskroom/cask
else
  log "  Brew not detected, skipping tap"
fi

log "Installing casks"
cask "aws-vault"
cask "calibre"
cask "dropbox"
cask "gimp"
cask "google-chrome"
cask "imageoptim"
cask "iterm2"
cask "licecap"
cask "macdown"
cask "psequel"
cask "sequel-pro"
cask "slack"
cask "slate"
cask "sourcetree"
# cask "sublime-text" yes, true. but im on the dev channel
cask "tripmode"

log "Installing packages"
package "autojump"
package "coreutils"
package "heroku"
package "hub"
package "lastpass-cli"
package "the_silver_searcher"

