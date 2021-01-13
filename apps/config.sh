#! /bin/bash

PREFIX="APPS"
log "Begin Apps config"

log "Tapping the caskroom"
if hash brew 2>/dev/null; then
  log "  Brew detected, tapping additional casks"
  brew tap homebrew/cask-fonts
  brew tap homebrew/cask-drivers
  if [[ $UPDATE == true ]]; then
    log "  Upgrading casks"
    brew upgrade --cask -v
  fi
else
  log "  Brew not detected, skipping tap"
fi

if hash mas 2>/dev/null; then
  if [[ $UPDATE == true ]]; then
    log "  Mas detected, upgrading apps"
    brew upgrade --cask -v
  fi
fi

log "Installing casks"
cask_install "1password"
cask_install "authy"
cask_install "aws-vault"
cask_install "background-music"
cask_install "calibre"
cask_install "discord"
cask_install "dropbox"
cask_install "firefox"
cask_install "font-fira-code"
cask_install "gimp"
cask_install "google-chrome"
cask_install "imageoptim"
cask_install "iterm2"
cask_install "kensington-trackball-works"
cask_install "libreoffice"
cask_install "licecap"
cask_install "logitech-myharmony"
cask_install "macdown"
cask_install "psequel"
cask_install "sequel-pro"
cask_install "slack"
cask_install "slate"
cask_install "sourcetree"
# cask_install "sublime-text" yes, true. but im on the dev channel
cask_install "tripmode"
cask_install "visual-studio-code"
cask_install "whatsapp"

log "Installing packages"
brew_install "autojump"
brew_install "coreutils"
brew_install "direnv"
brew_install "heroku"
brew_install "hub"
brew_install "lastpass-cli"
brew_install "mas"
brew_install "redis"
brew_install "the_silver_searcher"
brew_install "watch"

log "Installing App Store applications"
mas_install "441258766" "Magnet"
mas_install "540348655" "Monosnap"
mas_install "926036361" "LastPass"
mas_install "425424353" "The Unarchiver"
mas_install "603117688" "CCMenu"
# mas_install "497799835" "Xcode" yup, but this is required before mas can be installed
